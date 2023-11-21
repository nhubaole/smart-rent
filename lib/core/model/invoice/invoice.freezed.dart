// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  int get orderCode => throw _privateConstructorUsedError;
  String get recieverId => throw _privateConstructorUsedError;
  String get recieverName => throw _privateConstructorUsedError;
  String get recieverPhoneNumber => throw _privateConstructorUsedError;
  String get recieverNumberBank => throw _privateConstructorUsedError;
  String get recieverBank => throw _privateConstructorUsedError;
  String get addressRoom => throw _privateConstructorUsedError;
  int get amountRoom => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get buyerId => throw _privateConstructorUsedError;
  String get buyerName => throw _privateConstructorUsedError;
  String get buyerEmail => throw _privateConstructorUsedError;
  String get buyerPhone => throw _privateConstructorUsedError;
  String get buyerAddress => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get items => throw _privateConstructorUsedError;
  String get cancelUrl => throw _privateConstructorUsedError;
  String get returnUrl => throw _privateConstructorUsedError;
  int get expireAt => throw _privateConstructorUsedError;
  String get signalture => throw _privateConstructorUsedError;
  String get paymentLinkId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {int orderCode,
      String recieverId,
      String recieverName,
      String recieverPhoneNumber,
      String recieverNumberBank,
      String recieverBank,
      String addressRoom,
      int amountRoom,
      String description,
      String buyerId,
      String buyerName,
      String buyerEmail,
      String buyerPhone,
      String buyerAddress,
      List<Map<String, dynamic>> items,
      String cancelUrl,
      String returnUrl,
      int expireAt,
      String signalture,
      String paymentLinkId});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCode = null,
    Object? recieverId = null,
    Object? recieverName = null,
    Object? recieverPhoneNumber = null,
    Object? recieverNumberBank = null,
    Object? recieverBank = null,
    Object? addressRoom = null,
    Object? amountRoom = null,
    Object? description = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? buyerEmail = null,
    Object? buyerPhone = null,
    Object? buyerAddress = null,
    Object? items = null,
    Object? cancelUrl = null,
    Object? returnUrl = null,
    Object? expireAt = null,
    Object? signalture = null,
    Object? paymentLinkId = null,
  }) {
    return _then(_value.copyWith(
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as int,
      recieverId: null == recieverId
          ? _value.recieverId
          : recieverId // ignore: cast_nullable_to_non_nullable
              as String,
      recieverName: null == recieverName
          ? _value.recieverName
          : recieverName // ignore: cast_nullable_to_non_nullable
              as String,
      recieverPhoneNumber: null == recieverPhoneNumber
          ? _value.recieverPhoneNumber
          : recieverPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      recieverNumberBank: null == recieverNumberBank
          ? _value.recieverNumberBank
          : recieverNumberBank // ignore: cast_nullable_to_non_nullable
              as String,
      recieverBank: null == recieverBank
          ? _value.recieverBank
          : recieverBank // ignore: cast_nullable_to_non_nullable
              as String,
      addressRoom: null == addressRoom
          ? _value.addressRoom
          : addressRoom // ignore: cast_nullable_to_non_nullable
              as String,
      amountRoom: null == amountRoom
          ? _value.amountRoom
          : amountRoom // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerName: null == buyerName
          ? _value.buyerName
          : buyerName // ignore: cast_nullable_to_non_nullable
              as String,
      buyerEmail: null == buyerEmail
          ? _value.buyerEmail
          : buyerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      buyerPhone: null == buyerPhone
          ? _value.buyerPhone
          : buyerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      buyerAddress: null == buyerAddress
          ? _value.buyerAddress
          : buyerAddress // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      cancelUrl: null == cancelUrl
          ? _value.cancelUrl
          : cancelUrl // ignore: cast_nullable_to_non_nullable
              as String,
      returnUrl: null == returnUrl
          ? _value.returnUrl
          : returnUrl // ignore: cast_nullable_to_non_nullable
              as String,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as int,
      signalture: null == signalture
          ? _value.signalture
          : signalture // ignore: cast_nullable_to_non_nullable
              as String,
      paymentLinkId: null == paymentLinkId
          ? _value.paymentLinkId
          : paymentLinkId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderCode,
      String recieverId,
      String recieverName,
      String recieverPhoneNumber,
      String recieverNumberBank,
      String recieverBank,
      String addressRoom,
      int amountRoom,
      String description,
      String buyerId,
      String buyerName,
      String buyerEmail,
      String buyerPhone,
      String buyerAddress,
      List<Map<String, dynamic>> items,
      String cancelUrl,
      String returnUrl,
      int expireAt,
      String signalture,
      String paymentLinkId});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCode = null,
    Object? recieverId = null,
    Object? recieverName = null,
    Object? recieverPhoneNumber = null,
    Object? recieverNumberBank = null,
    Object? recieverBank = null,
    Object? addressRoom = null,
    Object? amountRoom = null,
    Object? description = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? buyerEmail = null,
    Object? buyerPhone = null,
    Object? buyerAddress = null,
    Object? items = null,
    Object? cancelUrl = null,
    Object? returnUrl = null,
    Object? expireAt = null,
    Object? signalture = null,
    Object? paymentLinkId = null,
  }) {
    return _then(_$InvoiceImpl(
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as int,
      recieverId: null == recieverId
          ? _value.recieverId
          : recieverId // ignore: cast_nullable_to_non_nullable
              as String,
      recieverName: null == recieverName
          ? _value.recieverName
          : recieverName // ignore: cast_nullable_to_non_nullable
              as String,
      recieverPhoneNumber: null == recieverPhoneNumber
          ? _value.recieverPhoneNumber
          : recieverPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      recieverNumberBank: null == recieverNumberBank
          ? _value.recieverNumberBank
          : recieverNumberBank // ignore: cast_nullable_to_non_nullable
              as String,
      recieverBank: null == recieverBank
          ? _value.recieverBank
          : recieverBank // ignore: cast_nullable_to_non_nullable
              as String,
      addressRoom: null == addressRoom
          ? _value.addressRoom
          : addressRoom // ignore: cast_nullable_to_non_nullable
              as String,
      amountRoom: null == amountRoom
          ? _value.amountRoom
          : amountRoom // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerName: null == buyerName
          ? _value.buyerName
          : buyerName // ignore: cast_nullable_to_non_nullable
              as String,
      buyerEmail: null == buyerEmail
          ? _value.buyerEmail
          : buyerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      buyerPhone: null == buyerPhone
          ? _value.buyerPhone
          : buyerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      buyerAddress: null == buyerAddress
          ? _value.buyerAddress
          : buyerAddress // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      cancelUrl: null == cancelUrl
          ? _value.cancelUrl
          : cancelUrl // ignore: cast_nullable_to_non_nullable
              as String,
      returnUrl: null == returnUrl
          ? _value.returnUrl
          : returnUrl // ignore: cast_nullable_to_non_nullable
              as String,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as int,
      signalture: null == signalture
          ? _value.signalture
          : signalture // ignore: cast_nullable_to_non_nullable
              as String,
      paymentLinkId: null == paymentLinkId
          ? _value.paymentLinkId
          : paymentLinkId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl extends _Invoice with DiagnosticableTreeMixin {
  const _$InvoiceImpl(
      {required this.orderCode,
      required this.recieverId,
      required this.recieverName,
      required this.recieverPhoneNumber,
      required this.recieverNumberBank,
      required this.recieverBank,
      required this.addressRoom,
      required this.amountRoom,
      required this.description,
      required this.buyerId,
      required this.buyerName,
      required this.buyerEmail,
      required this.buyerPhone,
      required this.buyerAddress,
      required final List<Map<String, dynamic>> items,
      this.cancelUrl = 'https://your-cancel-url.com',
      this.returnUrl = 'https://your-success-url.com',
      this.expireAt = 1699814762,
      this.signalture = 'hashcode',
      this.paymentLinkId = 'paymentLink'})
      : _items = items,
        super._();

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final int orderCode;
  @override
  final String recieverId;
  @override
  final String recieverName;
  @override
  final String recieverPhoneNumber;
  @override
  final String recieverNumberBank;
  @override
  final String recieverBank;
  @override
  final String addressRoom;
  @override
  final int amountRoom;
  @override
  final String description;
  @override
  final String buyerId;
  @override
  final String buyerName;
  @override
  final String buyerEmail;
  @override
  final String buyerPhone;
  @override
  final String buyerAddress;
  final List<Map<String, dynamic>> _items;
  @override
  List<Map<String, dynamic>> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final String cancelUrl;
  @override
  @JsonKey()
  final String returnUrl;
  @override
  @JsonKey()
  final int expireAt;
  @override
  @JsonKey()
  final String signalture;
  @override
  @JsonKey()
  final String paymentLinkId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Invoice(orderCode: $orderCode, recieverId: $recieverId, recieverName: $recieverName, recieverPhoneNumber: $recieverPhoneNumber, recieverNumberBank: $recieverNumberBank, recieverBank: $recieverBank, addressRoom: $addressRoom, amountRoom: $amountRoom, description: $description, buyerId: $buyerId, buyerName: $buyerName, buyerEmail: $buyerEmail, buyerPhone: $buyerPhone, buyerAddress: $buyerAddress, items: $items, cancelUrl: $cancelUrl, returnUrl: $returnUrl, expireAt: $expireAt, signalture: $signalture, paymentLinkId: $paymentLinkId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Invoice'))
      ..add(DiagnosticsProperty('orderCode', orderCode))
      ..add(DiagnosticsProperty('recieverId', recieverId))
      ..add(DiagnosticsProperty('recieverName', recieverName))
      ..add(DiagnosticsProperty('recieverPhoneNumber', recieverPhoneNumber))
      ..add(DiagnosticsProperty('recieverNumberBank', recieverNumberBank))
      ..add(DiagnosticsProperty('recieverBank', recieverBank))
      ..add(DiagnosticsProperty('addressRoom', addressRoom))
      ..add(DiagnosticsProperty('amountRoom', amountRoom))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('buyerId', buyerId))
      ..add(DiagnosticsProperty('buyerName', buyerName))
      ..add(DiagnosticsProperty('buyerEmail', buyerEmail))
      ..add(DiagnosticsProperty('buyerPhone', buyerPhone))
      ..add(DiagnosticsProperty('buyerAddress', buyerAddress))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('cancelUrl', cancelUrl))
      ..add(DiagnosticsProperty('returnUrl', returnUrl))
      ..add(DiagnosticsProperty('expireAt', expireAt))
      ..add(DiagnosticsProperty('signalture', signalture))
      ..add(DiagnosticsProperty('paymentLinkId', paymentLinkId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.orderCode, orderCode) ||
                other.orderCode == orderCode) &&
            (identical(other.recieverId, recieverId) ||
                other.recieverId == recieverId) &&
            (identical(other.recieverName, recieverName) ||
                other.recieverName == recieverName) &&
            (identical(other.recieverPhoneNumber, recieverPhoneNumber) ||
                other.recieverPhoneNumber == recieverPhoneNumber) &&
            (identical(other.recieverNumberBank, recieverNumberBank) ||
                other.recieverNumberBank == recieverNumberBank) &&
            (identical(other.recieverBank, recieverBank) ||
                other.recieverBank == recieverBank) &&
            (identical(other.addressRoom, addressRoom) ||
                other.addressRoom == addressRoom) &&
            (identical(other.amountRoom, amountRoom) ||
                other.amountRoom == amountRoom) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.buyerName, buyerName) ||
                other.buyerName == buyerName) &&
            (identical(other.buyerEmail, buyerEmail) ||
                other.buyerEmail == buyerEmail) &&
            (identical(other.buyerPhone, buyerPhone) ||
                other.buyerPhone == buyerPhone) &&
            (identical(other.buyerAddress, buyerAddress) ||
                other.buyerAddress == buyerAddress) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.cancelUrl, cancelUrl) ||
                other.cancelUrl == cancelUrl) &&
            (identical(other.returnUrl, returnUrl) ||
                other.returnUrl == returnUrl) &&
            (identical(other.expireAt, expireAt) ||
                other.expireAt == expireAt) &&
            (identical(other.signalture, signalture) ||
                other.signalture == signalture) &&
            (identical(other.paymentLinkId, paymentLinkId) ||
                other.paymentLinkId == paymentLinkId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        orderCode,
        recieverId,
        recieverName,
        recieverPhoneNumber,
        recieverNumberBank,
        recieverBank,
        addressRoom,
        amountRoom,
        description,
        buyerId,
        buyerName,
        buyerEmail,
        buyerPhone,
        buyerAddress,
        const DeepCollectionEquality().hash(_items),
        cancelUrl,
        returnUrl,
        expireAt,
        signalture,
        paymentLinkId
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice extends Invoice {
  const factory _Invoice(
      {required final int orderCode,
      required final String recieverId,
      required final String recieverName,
      required final String recieverPhoneNumber,
      required final String recieverNumberBank,
      required final String recieverBank,
      required final String addressRoom,
      required final int amountRoom,
      required final String description,
      required final String buyerId,
      required final String buyerName,
      required final String buyerEmail,
      required final String buyerPhone,
      required final String buyerAddress,
      required final List<Map<String, dynamic>> items,
      final String cancelUrl,
      final String returnUrl,
      final int expireAt,
      final String signalture,
      final String paymentLinkId}) = _$InvoiceImpl;
  const _Invoice._() : super._();

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  int get orderCode;
  @override
  String get recieverId;
  @override
  String get recieverName;
  @override
  String get recieverPhoneNumber;
  @override
  String get recieverNumberBank;
  @override
  String get recieverBank;
  @override
  String get addressRoom;
  @override
  int get amountRoom;
  @override
  String get description;
  @override
  String get buyerId;
  @override
  String get buyerName;
  @override
  String get buyerEmail;
  @override
  String get buyerPhone;
  @override
  String get buyerAddress;
  @override
  List<Map<String, dynamic>> get items;
  @override
  String get cancelUrl;
  @override
  String get returnUrl;
  @override
  int get expireAt;
  @override
  String get signalture;
  @override
  String get paymentLinkId;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
