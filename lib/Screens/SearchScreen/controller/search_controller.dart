import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Constant/dummy_search_list.dart';
import '../../../Constant/selected_list.dart';
import '../../../Model/search_model.dart';

class SearchNotifier extends ChangeNotifier {
  List searchItems = [];

  bool isSearching = false;
  //String searchText = '';

  symptonSelected(var selected) {
    if (!selectedItems.contains(selected.name)) {
      selectedItems.add(selected.name);
      if (items.length < 1) {
        Map<String, String> rand = {
          'id': selected.id,
          "choice_id": "present",
          "source": "initial"
        };
        items.add(rand);
        print(items);
      } else {
        Map<String, String> rand = {'id': selected.id, "choice_id": "present"};
        items.add(rand);
      }
      print(selectedItems);
      notifyListeners();
    } else {
      Map<String, String> rand = {'id': selected.id, "choice_id": "present"};
      items.remove(rand);
      selectedItems.remove(selected);
      print(selectedItems);
      notifyListeners();
    }
  }

  searchOperation(String searchText, List<SearchModel> lists) async {
    searchItems.clear();
    if (isSearching == true) {
      for (int i = 0; i < lists.length; i++) {
        String data = lists[i].name!;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchItems.add(lists[i]);
        }
      }
    }
    notifyListeners();
  }
}

final searchNotifier = ChangeNotifierProvider((ref) => SearchNotifier());
