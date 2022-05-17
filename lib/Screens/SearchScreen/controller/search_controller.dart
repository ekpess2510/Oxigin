import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Constant/dummy_search_list.dart';
import '../../../Constant/selected_list.dart';

class SearchNotifier extends ChangeNotifier {
  List searchItems = [];

  bool isSearching = false;
  //String searchText = '';

  symptonSelected(var selected) {
    if (!selectedItems.contains(selected)) {
      selectedItems.add(selected);
      print(selectedItems);
      notifyListeners();
    } else {
      selectedItems.remove(selected);
      print(selectedItems);
      notifyListeners();
    }
  }

  searchOperation(String searchText) async {
    searchItems.clear();
    if (isSearching == true) {
      for (int i = 0; i < lists.length; i++) {
        String data = lists[i].title;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchItems.add(lists[i]);
        }
      }
    }
    notifyListeners();
  }
}

final searchNotifier = ChangeNotifierProvider((ref) => SearchNotifier());
