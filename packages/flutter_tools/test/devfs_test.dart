// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter_tools/src/asset.dart';
import 'package:flutter_tools/src/base/io.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/devfs.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/vmservice.dart';
import 'package:test/test.dart';

import 'src/common.dart';
import 'src/context.dart';
import 'src/mocks.dart';

void main() {
  final String filePath = fs.path.join('lib', 'foo.txt');
  final String filePath2 = fs.path.join('foo', 'bar.txt');
  Directory tempDir;
  String basePath;
  DevFS devFS;
  final AssetBundle assetBundle = new AssetBundle();

  group('DevFSContent', () {
    test('bytes', () {
      final DevFSByteContent content = new DevFSByteContent(<int>[4, 5, 6]);
      expect(content.bytes, orderedEquals(<int>[4, 5, 6]));
      expect(content.isModified, isTrue);
      expect(content.isModified, isFalse);
      content.bytes = <int>[7, 8, 9, 2];
      expect(content.bytes, orderedEquals(<int>[7, 8, 9, 2]));
      expect(content.isModified, isTrue);
      expect(content.isModified, isFalse);
    });
    test('string', () {
      final DevFSStringContent content = new DevFSStringContent('some string');
      expect(content.string, 'some string');
      expect(content.bytes, orderedEquals(UTF8.encode('some string')));
      expect(content.isModified, isTrue);
      expect(content.isModified, isFalse);
      content.string = 'another string';
      expect(content.string, 'another string');
      expect(content.bytes, orderedEquals(UTF8.encode('another string')));
      expect(content.isModified, isTrue);
      expect(content.isModified, isFalse);
      content.bytes = UTF8.encode('foo bar');
      expect(content.string, 'foo bar');
      expect(content.bytes, orderedEquals(UTF8.encode('foo bar')));
      expect(content.isModified, isTrue);
      expect(content.isModified, isFalse);
    });
  });

  group('devfs local', () {
    final MockDevFSOperations devFSOperations = new MockDevFSOperations();

    setUpAll(() {
      tempDir = _newTempDir();
      basePath = tempDir.path;
    });
    tearDownAll(_cleanupTempDirs);

    testUsingContext('create dev file system', () async {
      // simulate workspace
      final File file = fs.file(fs.path.join(basePath, filePath));
      await file.parent.create(recursive: true);
      file.writeAsBytesSync(<int>[1, 2, 3]);
      _packages['my_project'] = fs.path.toUri('lib');

      // simulate package
      await _createPackage('somepkg', 'somefile.txt');

      devFS = new DevFS.operations(devFSOperations, 'test', tempDir);
      await devFS.create();
      devFSOperations.expectMessages(<String>['create test']);
      expect(devFS.assetPathsToEvict, isEmpty);

      final int bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[
        'writeFile test .packages',
        'writeFile test lib/foo.txt',
        'writeFile test packages/somepkg/somefile.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);

      final List<String> packageSpecOnDevice = LineSplitter.split(UTF8.decode(
          await devFSOperations.devicePathToContent[fs.path.toUri('.packages')].contentsAsBytes()
      )).toList();
      expect(packageSpecOnDevice,
          unorderedEquals(<String>['my_project:lib/', 'somepkg:packages/somepkg/'])
      );

      expect(bytes, 48);
    });
    testUsingContext('add new file to local file system', () async {
      final File file = fs.file(fs.path.join(basePath, filePath2));
      await file.parent.create(recursive: true);
      file.writeAsBytesSync(<int>[1, 2, 3, 4, 5, 6, 7]);
      final int bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[
        'writeFile test foo/bar.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 7);
    });
    testUsingContext('modify existing file on local file system', () async {
      final File file = fs.file(fs.path.join(basePath, filePath));
      // Set the last modified time to 5 seconds in the past.
      updateFileModificationTime(file.path, new DateTime.now(), -5);
      int bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 0);

      await file.writeAsBytes(<int>[1, 2, 3, 4, 5, 6]);
      bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[
        'writeFile test lib/foo.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 6);
    });
    testUsingContext('delete a file from the local file system', () async {
      final File file = fs.file(fs.path.join(basePath, filePath));
      await file.delete();
      final int bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[
        'deleteFile test lib/foo.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 0);
    });
    testUsingContext('add new package', () async {
      await _createPackage('newpkg', 'anotherfile.txt');
      final int bytes = await devFS.update();
      devFSOperations.expectMessages(<String>[
        'writeFile test .packages',
        'writeFile test packages/newpkg/anotherfile.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 69);
    });
    testUsingContext('add new package with double slashes in URI', () async {
      String packageName = 'doubleslashpkg';
      await _createPackage(packageName, 'somefile.txt', doubleSlash: true);

      Set<String> fileFilter = new Set<String>();
      List<Uri> pkgUris = <Uri>[fs.path.toUri(basePath)]..addAll(_packages.values);
      for (Uri pkgUri in pkgUris) {
        if (!pkgUri.isAbsolute) {
          pkgUri = fs.path.toUri(fs.path.join(basePath, pkgUri.path));
        }
        fileFilter.addAll(fs.directory(pkgUri)
            .listSync(recursive: true)
            .where((FileSystemEntity file) => file is File)
            .map((FileSystemEntity file) => fs.path.canonicalize(file.path))
            .toList());
      }

      int bytes = await devFS.update(fileFilter: fileFilter);
      devFSOperations.expectMessages(<String>[
        'writeFile test .packages',
        'writeFile test packages/doubleslashpkg/somefile.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 109);
    });
    testUsingContext('add an asset bundle', () async {
      assetBundle.entries['a.txt'] = new DevFSStringContent('abc');
      final int bytes = await devFS.update(bundle: assetBundle, bundleDirty: true);
      devFSOperations.expectMessages(<String>[
        'writeFile test ${_inAssetBuildDirectory('a.txt')}',
      ]);
      expect(devFS.assetPathsToEvict, unorderedMatches(<String>['a.txt']));
      devFS.assetPathsToEvict.clear();
      expect(bytes, 3);
    });
    testUsingContext('add a file to the asset bundle - bundleDirty', () async {
      assetBundle.entries['b.txt'] = new DevFSStringContent('abcd');
      final int bytes = await devFS.update(bundle: assetBundle, bundleDirty: true);
      // Expect entire asset bundle written because bundleDirty is true
      devFSOperations.expectMessages(<String>[
        'writeFile test ${_inAssetBuildDirectory('a.txt')}',
        'writeFile test ${_inAssetBuildDirectory('b.txt')}',
      ]);
      expect(devFS.assetPathsToEvict, unorderedMatches(<String>[
        'a.txt', 'b.txt']));
      devFS.assetPathsToEvict.clear();
      expect(bytes, 7);
    });
    testUsingContext('add a file to the asset bundle', () async {
      assetBundle.entries['c.txt'] = new DevFSStringContent('12');
      final int bytes = await devFS.update(bundle: assetBundle);
      devFSOperations.expectMessages(<String>[
        'writeFile test ${_inAssetBuildDirectory('c.txt')}',
      ]);
      expect(devFS.assetPathsToEvict, unorderedMatches(<String>[
        'c.txt']));
      devFS.assetPathsToEvict.clear();
      expect(bytes, 2);
    });
    testUsingContext('delete a file from the asset bundle', () async {
      assetBundle.entries.remove('c.txt');
      final int bytes = await devFS.update(bundle: assetBundle);
      devFSOperations.expectMessages(<String>[
        'deleteFile test ${_inAssetBuildDirectory('c.txt')}',
      ]);
      expect(devFS.assetPathsToEvict, unorderedMatches(<String>['c.txt']));
      devFS.assetPathsToEvict.clear();
      expect(bytes, 0);
    });
    testUsingContext('delete all files from the asset bundle', () async {
      assetBundle.entries.clear();
      final int bytes = await devFS.update(bundle: assetBundle, bundleDirty: true);
      devFSOperations.expectMessages(<String>[
        'deleteFile test ${_inAssetBuildDirectory('a.txt')}',
        'deleteFile test ${_inAssetBuildDirectory('b.txt')}',
      ]);
      expect(devFS.assetPathsToEvict, unorderedMatches(<String>[
        'a.txt', 'b.txt'
      ]));
      devFS.assetPathsToEvict.clear();
      expect(bytes, 0);
    });
    testUsingContext('delete dev file system', () async {
      await devFS.destroy();
      devFSOperations.expectMessages(<String>['destroy test']);
      expect(devFS.assetPathsToEvict, isEmpty);
    });
  });

  group('devfs remote', () {
    MockVMService vmService;

    setUpAll(() async {
      tempDir = _newTempDir();
      basePath = tempDir.path;
      vmService = new MockVMService();
      await vmService.setUp();
    });
    tearDownAll(() async {
      await vmService.tearDown();
      _cleanupTempDirs();
    });

    testUsingContext('create dev file system', () async {
      // simulate workspace
      final File file = fs.file(fs.path.join(basePath, filePath));
      await file.parent.create(recursive: true);
      file.writeAsBytesSync(<int>[1, 2, 3]);

      // simulate package
      await _createPackage('somepkg', 'somefile.txt');

      devFS = new DevFS(vmService, 'test', tempDir);
      await devFS.create();
      vmService.expectMessages(<String>['create test']);
      expect(devFS.assetPathsToEvict, isEmpty);

      final int bytes = await devFS.update();
      vmService.expectMessages(<String>[
        'writeFile test .packages',
        'writeFile test lib/foo.txt',
        'writeFile test packages/somepkg/somefile.txt',
      ]);
      expect(devFS.assetPathsToEvict, isEmpty);
      expect(bytes, 48);
    }, timeout: const Timeout(const Duration(seconds: 5)));

    testUsingContext('delete dev file system', () async {
      await devFS.destroy();
      vmService.expectMessages(<String>['_deleteDevFS {fsName: test}']);
      expect(devFS.assetPathsToEvict, isEmpty);
    });
  });
}

class MockVMService extends BasicMock implements VMService {
  Uri _httpAddress;
  HttpServer _server;
  MockVM _vm;

  MockVMService() {
    _vm = new MockVM(this);
  }

  @override
  Uri get httpAddress => _httpAddress;

  @override
  VM get vm => _vm;

  Future<Null> setUp() async {
    _server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 0);
    _httpAddress = Uri.parse('http://127.0.0.1:${_server.port}');
    _server.listen((HttpRequest request) {
      final String fsName = request.headers.value('dev_fs_name');
      final String devicePath = UTF8.decode(BASE64.decode(request.headers.value('dev_fs_path_b64')));
      messages.add('writeFile $fsName $devicePath');
      request.drain<List<int>>().then<Null>((List<int> value) {
        request.response
          ..write('Got it')
          ..close();
      });
    });
  }

  Future<Null> tearDown() async {
    await _server.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockVM implements VM {
  final MockVMService _service;
  final Uri _baseUri = Uri.parse('file:///tmp/devfs/test');

  MockVM(this._service);

  @override
  Future<Map<String, dynamic>> createDevFS(String fsName) async {
    _service.messages.add('create $fsName');
    return <String, dynamic>{'uri': '$_baseUri'};
  }

  @override
  Future<Map<String, dynamic>> invokeRpcRaw(String method, {
    Map<String, dynamic> params: const <String, dynamic>{},
    Duration timeout,
    bool timeoutFatal: true,
  }) async {
    _service.messages.add('$method $params');
    return <String, dynamic>{'success': true};
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}


final List<Directory> _tempDirs = <Directory>[];
final Map <String, Uri> _packages = <String, Uri>{};

Directory _newTempDir() {
  final Directory tempDir = fs.systemTempDirectory.createTempSync('devfs${_tempDirs.length}');
  _tempDirs.add(tempDir);
  return tempDir;
}

void _cleanupTempDirs() {
  while (_tempDirs.isNotEmpty) {
    _tempDirs.removeLast().deleteSync(recursive: true);
  }
}

Future<Null> _createPackage(String pkgName, String pkgFileName, { bool doubleSlash: false }) async {
  final Directory pkgTempDir = _newTempDir();
  String pkgFilePath = fs.path.join(pkgTempDir.path, pkgName, 'lib', pkgFileName);
  if (doubleSlash) {
    // Force two separators into the path.
    String doubleSlash = fs.path.separator + fs.path.separator;
    pkgFilePath = pkgTempDir.path + doubleSlash  + fs.path.join(pkgName, 'lib', pkgFileName);
  }
  final File pkgFile = fs.file(pkgFilePath);
  await pkgFile.parent.create(recursive: true);
  pkgFile.writeAsBytesSync(<int>[11, 12, 13]);
  _packages[pkgName] = fs.path.toUri(pkgFile.parent.path);
  final StringBuffer sb = new StringBuffer();
  _packages.forEach((String pkgName, Uri pkgUri) {
    sb.writeln('$pkgName:$pkgUri');
  });
  fs.file(fs.path.join(_tempDirs[0].path, '.packages')).writeAsStringSync(sb.toString());
}

String _inAssetBuildDirectory(String filename) {
  return '${fs.path.toUri(getAssetBuildDirectory()).path}/$filename';
}
