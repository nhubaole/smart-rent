// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReviewTicket _$ReviewTicketFromJson(Map<String, dynamic> json) {
  return _ReviewTicket.fromJson(json);
}

/// @nodoc
mixin _$ReviewTicket {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get invoiceId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  num get createdAt => throw _privateConstructorUsedError;
  List<String> get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewTicketCopyWith<ReviewTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewTicketCopyWith<$Res> {
  factory $ReviewTicketCopyWith(
          ReviewTicket value, $Res Function(ReviewTicket) then) =
      _$ReviewTicketCopyWithImpl<$Res, ReviewTicket>;
  @useResult
  $Res call(
      {String id,
      String roomId,
      String userId,
      String invoiceId,
      String title,
      String content,
      double rating,
      num createdAt,
      List<String> image});
}

/// @nodoc
class _$ReviewTicketCopyWithImpl<$Res, $Val extends ReviewTicket>
    implements $ReviewTicketCopyWith<$Res> {
  _$ReviewTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? userId = null,
    Object? invoiceId = null,
    Object? title = null,
    Object? content = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as num,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewTicketImplCopyWith<$Res>
    implements $ReviewTicketCopyWith<$Res> {
  factory _$$ReviewTicketImplCopyWith(
          _$ReviewTicketImpl value, $Res Function(_$ReviewTicketImpl) then) =
      __$$ReviewTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomId,
      String userId,
      String invoiceId,
      String title,
      String content,
      double rating,
      num createdAt,
      List<String> image});
}

/// @nodoc
class __$$ReviewTicketImplCopyWithImpl<$Res>
    extends _$ReviewTicketCopyWithImpl<$Res, _$ReviewTicketImpl>
    implements _$$ReviewTicketImplCopyWith<$Res> {
  __$$ReviewTicketImplCopyWithImpl(
      _$ReviewTicketImpl _value, $Res Function(_$ReviewTicketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? userId = null,
    Object? invoiceId = null,
    Object? title = null,
    Object? content = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? image = null,
  }) {
    return _then(_$ReviewTicketImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as num,
      image: null == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewTicketImpl extends _ReviewTicket with DiagnosticableTreeMixin {
  const _$ReviewTicketImpl(
      {required this.id,
      required this.roomId,
      required this.userId,
      required this.invoiceId,
      required this.title,
      required this.content,
      required this.rating,
      required this.createdAt,
      final List<String> image = const []})
      : _image = image,
        super._();

  factory _$ReviewTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewTicketImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String userId;
  @override
  final String invoiceId;
  @override
  final String title;
  @override
  final String content;
  @override
  final double rating;
  @override
  final num createdAt;
  final List<String> _image;
  @override
  @JsonKey()
  List<String> get image {
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_image);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewTicket(id: $id, roomId: $roomId, userId: $userId, invoiceId: $invoiceId, title: $title, content: $content, rating: $rating, createdAt: $createdAt, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewTicket'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('roomId', roomId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('invoiceId', invoiceId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._image, _image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomId,
      userId,
      invoiceId,
      title,
      content,
      rating,
      createdAt,
      const DeepCollectionEquality().hash(_image));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewTicketImplCopyWith<_$ReviewTicketImpl> get copyWith =>
      __$$ReviewTicketImplCopyWithImpl<_$ReviewTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewTicketImplToJson(
      this,
    );
  }
}

abstract class _ReviewTicket extends ReviewTicket {
  const factory _ReviewTicket(
      {required final String id,
      required final String roomId,
      required final String userId,
      required final String invoiceId,
      required final String title,
      required final String content,
      required final double rating,
      required final num createdAt,
      final List<String> image}) = _$ReviewTicketImpl;
  const _ReviewTicket._() : super._();

  factory _ReviewTicket.fromJson(Map<String, dynamic> json) =
      _$ReviewTicketImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get userId;
  @override
  String get invoiceId;
  @override
  String get title;
  @override
  String get content;
  @override
  double get rating;
  @override
  num get createdAt;
  @override
  List<String> get image;
  @override
  @JsonKey(ignore: true)
  _$$ReviewTicketImplCopyWith<_$ReviewTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
