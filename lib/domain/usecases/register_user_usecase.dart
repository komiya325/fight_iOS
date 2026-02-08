import '../../data/signup/datastore/signup_datastore.dart';
import '../entity/user.dart';

/// ユーザー登録ユースケース
///
/// ニックネームを受け取り、ユーザー登録APIを呼び出してUser Entityを返す
class RegisterUserUseCase {
  final SignupDataStore _dataStore;

  RegisterUserUseCase(this._dataStore);

  /// ユーザー登録を実行する
  Future<User> execute({required String name}) {
    return _dataStore.registerUser(name: name);
  }
}
