import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/model/contract/contract_create_model.dart';
import 'package:smart_rent/core/model/contract/contract_sign_model.dart';
import 'package:smart_rent/core/model/contract_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class ContractRepo {
  Future<ResponseModel<List<ContractModel>>> getContracts();
  Future<ResponseModel<ContractByIdModel>> getContractByID(int id);
  Future<ResponseModel<List<ContractByStatusModel>>> getContractByStatus(
      int status);
  Future<ResponseModel<ContractModel>> createContractTemplate(
      ContractModel contract);
  Future<ResponseModel<ContractModel>> getTemplateByAddress(String address);
  Future<ResponseModel<ContractCreateModel>> createContract(
      ContractCreateModel contract);
  Future<ResponseModel<ContractModel>> updateContract(ContractModel contract);
  Future<ResponseModel<bool>> signContract(ContractSignModel contractSign);
  Future<ResponseModel<bool>> declineContract(int id);
  Future<void> deleteContract(String id);
}
