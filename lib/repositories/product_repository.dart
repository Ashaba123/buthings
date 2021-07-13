abstract class IProductRepository {
  void getAllProducts();
  getProduct(int id);
  createProduct(int id);
  updateProduct(int id);
  deleteProduct(int id);
}

class ProductRepository extends IProductRepository {
  @override
  void getAllProducts() {}

  @override
  createProduct(int id) {
    throw UnimplementedError();
  }

  @override
  deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  getProduct(int id) {
    throw UnimplementedError();
  }

  @override
  updateProduct(int id) {
    throw UnimplementedError();
  }
}
