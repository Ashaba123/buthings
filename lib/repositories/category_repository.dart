abstract class ICategoryRepository {
  void getAllCategories();
  getCategory(int id);
  createCategory(int id);
  updateCategory(int id);
  deleteCategory(int id);
}

class CategoryRepository extends ICategoryRepository {
  @override
  void getAllCategories() {
  }

  @override
  createCategory(int id) {
    throw UnimplementedError();
  }

  @override
  deleteCategory(int id) {
    throw UnimplementedError();
  }

  @override
  getCategory(int id) {
    throw UnimplementedError();
  }

  @override
  updateCategory(int id) {
    throw UnimplementedError();
  }
}
