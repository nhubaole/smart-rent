// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class RatingTenantCreateModel {
  int? tenantId;
  int? paymentRating;
  int? propertyCareRating;
  int? neighborDisturbanceRating;
  int? contractComplianceRating;
  int? overallRating;
  String? comment;
  List<String>? images;

  RatingTenantCreateModel({
    this.tenantId,
    this.paymentRating,
    this.propertyCareRating,
    this.neighborDisturbanceRating,
    this.contractComplianceRating,
    this.overallRating,
    this.comment,
    this.images,
  });

  get value => null;

  Future<FormData> toFormData() async {
    FormData formData = FormData();
    if (images != null) {
      for (final imagePath in images!) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(
              imagePath,
            ),
          ),
        );
      }
    }

    formData.fields
      ..add(MapEntry('tenant_id', tenantId.toString()))
      ..add(MapEntry('payment_rating', paymentRating.toString()))
      ..add(MapEntry('property_care_rating', propertyCareRating.toString()))
      ..add(MapEntry('neighborhood_disturbance_rating',
          neighborDisturbanceRating.toString()))
      ..add(MapEntry(
          'contract_compliance_rating', contractComplianceRating.toString()))
      ..add(MapEntry('overall_rating', overallRating.toString()))
      ..add(MapEntry('comments', comment ?? ''));

    return formData;
  }

  @override
  String toString() {
    return 'RatingTenantCreateModel(tenantId: $tenantId, paymentRating: $paymentRating, propertyCareRating: $propertyCareRating, neighborDisturbanceRating: $neighborDisturbanceRating, contractComplianceRating: $contractComplianceRating, overallRating: $overallRating, comment: $comment, images: $images)';
  }
}
