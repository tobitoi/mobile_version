import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/data/response/response..dart';

class ItemCategoryRepos {
  ItemCategoryApi _itemCategoryApi = ItemCategoryApi();

  Future<List<Item>> getItemRepo(int page, int size) {
    return _itemCategoryApi.getItem(page, size);
  }

  Future<bool> addItemRepos(Item itemRequest) {
    return _itemCategoryApi.addItem(itemRequest);
  }

  Stream<int> deleteItemRepos(int id) {
    return _itemCategoryApi.deleteItem(id);
  }

  Future<CategoryResponse> getCategoryRepo() {
    return _itemCategoryApi.getCategory();
  }

  Future<bool> editItemRepos(Item itemRequest) {
    return _itemCategoryApi.updateItem(itemRequest);
  }

  Future<List<Item>> searhItemRepos(String name) {
    return _itemCategoryApi.getItembyName(name);
  }

  Future<void> getItemReachableRepo() {
    return _itemCategoryApi.getItemReachable();
  }
}
