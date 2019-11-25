import 'package:mobile_version/data/response/response..dart';
import 'package:mobile_version/main.dart';
import 'package:mobile_version/repository/item_category_repo.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final ItemCategoryRepos itemCategoryRepos;
  final BehaviorSubject<CategoryResponse> _subjectCategory =
      BehaviorSubject<CategoryResponse>();

  CategoryBloc(this.itemCategoryRepos);

  category() async {
    CategoryResponse categoryData = await itemCategoryRepos.getCategoryRepo();
    _subjectCategory.sink.add(categoryData);
  }

  dispose() {
    _subjectCategory.close();
  }

  BehaviorSubject<CategoryResponse> get subjectCategory => _subjectCategory;
}

final categoryBloc = CategoryBloc(itemCategoryRepos);
