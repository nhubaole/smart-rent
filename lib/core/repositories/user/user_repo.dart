import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/user/user_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/model/user/user_update_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_update_info_model.dart';

abstract class UserRepo {
  Future<ResponseModel<List<UserModel>>> getAllUsers();
  Future<ResponseModel<UserModel>> getUserById({required int id});
  Future<ResponseModel<int>> updateInfo(
      {required UserUpdateInfoModel userUpdateInfoModel});
  Future<ResponseModel<UserModel>> getCurrentUser(
      {required String accessToken});
  Future<ResponseModel?> updateDeviceToken(
      {required String deviceToken});
  Future<ResponseModel<int>> updateBankInfo(
      {required UserUpdateBankInfoModel userUpdateBankInfoModel});
  Future<ResponseModel<UserBankInfoModel>> getBankInfo();
}
