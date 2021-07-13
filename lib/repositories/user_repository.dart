abstract class IUserRepository {
  void getAllUsers();
  getUser(int id);
  createUser(int id);
  updateUser(int id);
  deleteUser(int id);
}

class UserRepository extends IUserRepository {
  @override
  void getAllUsers() {
  }

  @override
  createUser(int id) {

    throw UnimplementedError();
  }

  @override
  deleteUser(int id) {

    throw UnimplementedError();
  }

  @override
  getUser(int id) {
    throw UnimplementedError();
  }

  @override
  updateUser(int id) {

    throw UnimplementedError();
  }
}
