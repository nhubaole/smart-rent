import '../../model/response/request_model.dart';

abstract class AuthRepo {
  Future<ResponseModel> login({
    required String phoneNumber,
    required String password,
  });

  Future<ResponseModel> register({
    required String phoneNumber,
    required String fullName,
    required String address,
    required String password,
  });

  Future<ResponseModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  });
}
