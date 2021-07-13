abstract class IOrderRepository {
  void getAllOrders();
  getOrder(int id);
  createOrder(int id);
  updateOrder(int id);
  deleteOrder(int id);
}

class OrderRepository extends IOrderRepository {
  @override
  void getAllOrders() {
  }

  @override
  createOrder(int id) {

    throw UnimplementedError();
  }

  @override
  deleteOrder(int id) {

    throw UnimplementedError();
  }

  @override
  getOrder(int id) {

    throw UnimplementedError();
  }

  @override
  updateOrder(int id) {

    throw UnimplementedError();
  }
}
