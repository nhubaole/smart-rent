import 'dart:convert';

import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/model/contract/contract_create_model.dart';
import 'package:smart_rent/core/model/contract/contract_sign_model.dart';
import 'package:smart_rent/core/model/contract_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class ContractRepoImpl extends ContractRepo {
  final Log log;
  final DioProvider dio;
  ContractRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();

  @override
  Future<ResponseModel<bool>> declineContract(int id) async {
    final url = '/contracts/decline/$id';
    try {
      final response = await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: true,
      );
    } catch (e) {
      log.e('declineContract', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<ContractCreateModel>> createContract(
    ContractCreateModel contract,
  ) async {
    const url = '/contracts';
    
    try {
      final response = await dio.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: contract.toJson(),
      );

      return ResponseModel<ContractCreateModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: null,
      );
    } catch (e) {
      log.e('createContract', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<ContractModel>> createContractTemplate(
      ContractModel contract) {
    // TODO: implement createContractTemplate
    throw UnimplementedError();
  }

  @override
  Future<void> deleteContract(String id) {
    // TODO: implement deleteContract
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ContractByIdModel>> getContractByID(int id) async {
    final url = '/contracts/$id';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<ContractByIdModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: ContractByIdModel.fromMap(
          response.data['data'] as Map<String, dynamic>,
        ),
      );
    } catch (e) {
      log.e('getContractByID', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<ContractByStatusModel>>> getContractByStatus(
    int status,
  ) async {
    final url = '/contracts/status/$status';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<ContractByStatusModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? List<ContractByStatusModel>.from((response.data['data'] as List)
            .map((c) =>
                    ContractByStatusModel.fromMap(c as Map<String, dynamic>)))
            : [],
      );
    } catch (e) {
      log.e('getContractByStatus', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<ContractModel>>> getContracts() {
    // TODO: implement getContracts
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ContractModel>> getTemplateByAddress(String address) {
    // TODO: implement getTemplateByAddress
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> signContract(
    ContractSignModel contractSign,
  ) async {
    const url = '/contracts/sign';

    print(contractSign.toMap());

    try {
      final response = await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: contractSign.toMap(),
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'],
      );
    } catch (e) {
      log.e('signContract', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<ContractModel>> updateContract(ContractModel contract) {
    // TODO: implement updateContract
    throw UnimplementedError();
  }
}
