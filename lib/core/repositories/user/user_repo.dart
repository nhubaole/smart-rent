import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/user_model.dart';

abstract class UserRepo {
  Future<ResponseModel<List<UserModel>>> getAllUsers();
  Future<ResponseModel<UserModel>> getUserById({required int id});
  Future<ResponseModel<UserModel>> updateUser();
  Future<ResponseModel<UserModel>> getCurrentUser(
      {required String accessToken});
}
