import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Model/search_model.dart';
import '../Service/api_service.dart';

const _secureStorage = FlutterSecureStorage();

final searchDataProvider = FutureProvider<List<SearchModel>>((ref) async {
  var age = await _secureStorage.read(key: 'age');
  return ref.read(apiProvider).get('symptoms?age.value=$age');
});

final reasonDataProvider = FutureProvider<List<SearchModel>>((ref) async {
  var age = await _secureStorage.read(key: 'age');
  return ref.read(apiProvider).get('symptoms?age.value=$age');
});
