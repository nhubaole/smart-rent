import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/model/contract/contract_template_request.dart';
import 'package:smart_rent/core/model/contract/template_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/chat/chat_repo_impl.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo_impl.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/chat/socket_service.dart';
import 'package:smart_rent/modules/contract_creation/widgets/confirm_use_template_sheet.dart';

class DetailRequestController extends GetxController {
  RentalRequestByIdModel? rentalRequestById;
  RequestInfo? requestInfo;

  final AppManager appManager = AppManager.instance;
  final isLoadingData = LoadingType.INIT.obs;

  UserModel get userModel => appManager.currentUser!;
  bool get isLandlord => userModel.role == 1;
  RequestRoomStatus get requestStatus =>
      RequestRoomStatusExtension.fromInt(rentalRequestById!.status!);

  final SocketService _socketService = Get.find();

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is RequestInfo) {
        requestInfo = args;
        fetchRentalRequestById(requestInfo!);
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchRentalRequestById(RequestInfo requestInfo) async {
    isLoadingData.value = LoadingType.LOADING;
    final rq =
        await RentalRequestRepoImpl().getRentalRequestById(requestInfo.id!);
    if (rq.isSuccess()) {
      rentalRequestById = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  onApproveRequest() async {
    OverlayLoading.show();
    final rq = await RentalRequestRepoImpl()
        .approveRentalRequest(rentalRequestById!.id!);
    if (rq.isSuccess()) {
      int currentUserId = AppManager().currentUser?.id ?? 0;
      final response = await ChatRepoImpl()
          .getConversationsByUser(userID: AppManager().currentUser?.id ?? 0);
      final conversation = response.data?.where((e) =>
          (e.userA == currentUserId &&
              e.userB == rentalRequestById?.sender?.id) ||
          (e.userB == currentUserId &&
              e.userA == rentalRequestById?.sender?.id));
      int conversationId = 0;
      if (conversation == null || conversation.isEmpty) {
        final newConversation = await ChatRepoImpl()
            .createConversation(rentalRequestById?.sender?.id ?? 0);
        conversationId = newConversation.data ?? 0;
      } else {
        conversationId = conversation.first.id;
      }

      final rentAutoContent = {
        "rental_id": rentalRequestById?.id,
        "room_title": rentalRequestById?.room?.title,
        "room_address": rentalRequestById?.room?.addresses?.join(", "),
      };

      _socketService.sendMessage({
        'sender_id': AppManager().currentUser?.id,
        'receiver_id': rentalRequestById?.sender?.id,
        'conversation_id': conversationId,
        'content': null,
        'type': 2,
        'rent_auto_content': rentAutoContent,
      });

      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Chấp nhận yêu cầu thành công',
        message:
            'Bạn đã tiếp nhận yêu cầu thành công, hãy tiếp tục bước tiếp theo',
        isError: false,
      );

      Get.until((route) => route.settings.name == AppRoutes.root);
      Get.toNamed(AppRoutes.chat, arguments: {
        'conversationId': conversationId,
        'companionName': rentalRequestById?.sender?.fullName,
        'companionAvatarUrl': rentalRequestById?.sender?.avatarUrl,
        'companionId': rentalRequestById?.sender?.id,
      });
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  onRejectRequest() async {
    OverlayLoading.show();
    final rq = await RentalRequestRepoImpl()
        .declineRentalRequest(rentalRequestById!.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Từ chối yêu cầu thành công',
        message:
            'Bạn đã từ chối yêu cầu thành công, hãy tiếp tục bước tiếp theo',
        isError: false,
      );
      // TODO: nav to messgae
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  void onNavLandlordContractCreate() async {
    final template = await getTemplateForContract();

    if (template != null) {
      Get.bottomSheet(
        ConfirmUseTemplateSheet(
          onConfirm: () {
            Get.back();
            Get.toNamed(AppRoutes.landlordContractCreate, arguments: {
              'rental_request_by_id': rentalRequestById,
              'contract_template': template
            });
          },
          onReject: () {
            Get.back();
            Get.toNamed(AppRoutes.landlordContractCreate, arguments: {
              'rental_request_by_id': rentalRequestById,
            });
          },
        ),
        isDismissible: true,
        enableDrag: false,
      );
    } else {
      Get.toNamed(AppRoutes.landlordContractCreate, arguments: {
        'rental_request_by_id': rentalRequestById,
      });
    }
  }

  Future<TemplateModel?> getTemplateForContract() async {
    final request = ContractTemplateAddressRequest(
      address: rentalRequestById?.room?.addresses ?? [],
    );

    final response = await ContractRepoImpl().getTemplateByAddress(request);
    return response.isSuccess() ? response.data : null;
  }

  void _showUseTemplateDialog(TemplateModel template) {
    Get.defaultDialog(
      title: "Sử dụng hợp đồng mẫu?",
      middleText:
          "Hệ thống đã tìm thấy hợp đồng mẫu cho địa chỉ này. Bạn có muốn sử dụng nó không?",
      textConfirm: "Dùng hợp đồng mẫu",
      textCancel: "Nhập thông tin mới",
      confirmTextColor: Colors.white,
      onConfirm: () {
        // applyTemplate(template);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  tenantCancelRequest() async {
    OverlayLoading.show();
    final rq = await RentalRequestRepoImpl()
        .declineRentalRequest(rentalRequestById!.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Hủy yêu cầu thành công',
        message: 'Bạn đã Hủy yêu cầu thành công',
        isError: false,
      );
      // TODO: nav to messgae
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  tenantEditRequest() {
    Get.toNamed(AppRoutes.tenantSentRentRequest, arguments: {
      'room_id': rentalRequestById!.id!,
    });
  }
}
