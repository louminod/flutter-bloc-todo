abstract class UserRepositoryInterface {
  Future<bool> isAuthenticated();

  Future<void> authenticate();

  Future<String> getUserId();
}
