import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/search_model.dart';
import '../Service/api_service.dart';

final searchDataProvider = FutureProvider<List<SearchModel>>((ref) async {
  return ref.read(apiProvider).get('symptoms?age.value=14');
});
