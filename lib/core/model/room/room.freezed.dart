// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get roomType => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get deposit => throw _privateConstructorUsedError;
  int get electricityCost => throw _privateConstructorUsedError;
  int get waterCost => throw _privateConstructorUsedError;
  int get internetCost => throw _privateConstructorUsedError;
  bool get hasParking => throw _privateConstructorUsedError;
  int get parkingFee => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;
  List<String> get utilities => throw _privateConstructorUsedError;
  String get createdByUid => throw _privateConstructorUsedError;
  String get dateTime => throw _privateConstructorUsedError;
  bool get isRented => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String roomType,
      int capacity,
      String gender,
      double area,
      int price,
      int deposit,
      int electricityCost,
      int waterCost,
      int internetCost,
      bool hasParking,
      int parkingFee,
      Location location,
      List<String> utilities,
      String createdByUid,
      String dateTime,
      bool isRented,
      String status,
      List<String> images});

  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? roomType = null,
    Object? capacity = null,
    Object? gender = null,
    Object? area = null,
    Object? price = null,
    Object? deposit = null,
    Object? electricityCost = null,
    Object? waterCost = null,
    Object? internetCost = null,
    Object? hasParking = null,
    Object? parkingFee = null,
    Object? location = null,
    Object? utilities = null,
    Object? createdByUid = null,
    Object? dateTime = null,
    Object? isRented = null,
    Object? status = null,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int,
      electricityCost: null == electricityCost
          ? _value.electricityCost
          : electricityCost // ignore: cast_nullable_to_non_nullable
              as int,
      waterCost: null == waterCost
          ? _value.waterCost
          : waterCost // ignore: cast_nullable_to_non_nullable
              as int,
      internetCost: null == internetCost
          ? _value.internetCost
          : internetCost // ignore: cast_nullable_to_non_nullable
              as int,
      hasParking: null == hasParking
          ? _value.hasParking
          : hasParking // ignore: cast_nullable_to_non_nullable
              as bool,
      parkingFee: null == parkingFee
          ? _value.parkingFee
          : parkingFee // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      utilities: null == utilities
          ? _value.utilities
          : utilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdByUid: null == createdByUid
          ? _value.createdByUid
          : createdByUid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      isRented: null == isRented
          ? _value.isRented
          : isRented // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$_RoomCopyWith(_$_Room value, $Res Function(_$_Room) then) =
      __$$_RoomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String roomType,
      int capacity,
      String gender,
      double area,
      int price,
      int deposit,
      int electricityCost,
      int waterCost,
      int internetCost,
      bool hasParking,
      int parkingFee,
      Location location,
      List<String> utilities,
      String createdByUid,
      String dateTime,
      bool isRented,
      String status,
      List<String> images});

  @override
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$_RoomCopyWithImpl<$Res> extends _$RoomCopyWithImpl<$Res, _$_Room>
    implements _$$_RoomCopyWith<$Res> {
  __$$_RoomCopyWithImpl(_$_Room _value, $Res Function(_$_Room) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? roomType = null,
    Object? capacity = null,
    Object? gender = null,
    Object? area = null,
    Object? price = null,
    Object? deposit = null,
    Object? electricityCost = null,
    Object? waterCost = null,
    Object? internetCost = null,
    Object? hasParking = null,
    Object? parkingFee = null,
    Object? location = null,
    Object? utilities = null,
    Object? createdByUid = null,
    Object? dateTime = null,
    Object? isRented = null,
    Object? status = null,
    Object? images = null,
  }) {
    return _then(_$_Room(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int,
      electricityCost: null == electricityCost
          ? _value.electricityCost
          : electricityCost // ignore: cast_nullable_to_non_nullable
              as int,
      waterCost: null == waterCost
          ? _value.waterCost
          : waterCost // ignore: cast_nullable_to_non_nullable
              as int,
      internetCost: null == internetCost
          ? _value.internetCost
          : internetCost // ignore: cast_nullable_to_non_nullable
              as int,
      hasParking: null == hasParking
          ? _value.hasParking
          : hasParking // ignore: cast_nullable_to_non_nullable
              as bool,
      parkingFee: null == parkingFee
          ? _value.parkingFee
          : parkingFee // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      utilities: null == utilities
          ? _value._utilities
          : utilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdByUid: null == createdByUid
          ? _value.createdByUid
          : createdByUid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      isRented: null == isRented
          ? _value.isRented
          : isRented // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Room extends _Room {
  const _$_Room(
      {required this.id,
      required this.title,
      required this.description,
      required this.roomType,
      required this.capacity,
      required this.gender,
      required this.area,
      required this.price,
      required this.deposit,
      required this.electricityCost,
      required this.waterCost,
      required this.internetCost,
      required this.hasParking,
      required this.parkingFee,
      required this.location,
      required final List<String> utilities,
      required this.createdByUid,
      required this.dateTime,
      required this.isRented,
      required this.status,
      final List<String> images = const []})
      : _utilities = utilities,
        _images = images,
        super._();

  factory _$_Room.fromJson(Map<String, dynamic> json) => _$$_RoomFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String roomType;
  @override
  final int capacity;
  @override
  final String gender;
  @override
  final double area;
  @override
  final int price;
  @override
  final int deposit;
  @override
  final int electricityCost;
  @override
  final int waterCost;
  @override
  final int internetCost;
  @override
  final bool hasParking;
  @override
  final int parkingFee;
  @override
  final Location location;
  final List<String> _utilities;
  @override
  List<String> get utilities {
    if (_utilities is EqualUnmodifiableListView) return _utilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_utilities);
  }

  @override
  final String createdByUid;
  @override
  final String dateTime;
  @override
  final bool isRented;
  @override
  final String status;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'Room(id: $id, title: $title, description: $description, roomType: $roomType, capacity: $capacity, gender: $gender, area: $area, price: $price, deposit: $deposit, electricityCost: $electricityCost, waterCost: $waterCost, internetCost: $internetCost, hasParking: $hasParking, parkingFee: $parkingFee, location: $location, utilities: $utilities, createdByUid: $createdByUid, dateTime: $dateTime, isRented: $isRented, status: $status, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Room &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.electricityCost, electricityCost) ||
                other.electricityCost == electricityCost) &&
            (identical(other.waterCost, waterCost) ||
                other.waterCost == waterCost) &&
            (identical(other.internetCost, internetCost) ||
                other.internetCost == internetCost) &&
            (identical(other.hasParking, hasParking) ||
                other.hasParking == hasParking) &&
            (identical(other.parkingFee, parkingFee) ||
                other.parkingFee == parkingFee) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._utilities, _utilities) &&
            (identical(other.createdByUid, createdByUid) ||
                other.createdByUid == createdByUid) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.isRented, isRented) ||
                other.isRented == isRented) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        roomType,
        capacity,
        gender,
        area,
        price,
        deposit,
        electricityCost,
        waterCost,
        internetCost,
        hasParking,
        parkingFee,
        location,
        const DeepCollectionEquality().hash(_utilities),
        createdByUid,
        dateTime,
        isRented,
        status,
        const DeepCollectionEquality().hash(_images)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomCopyWith<_$_Room> get copyWith =>
      __$$_RoomCopyWithImpl<_$_Room>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomToJson(
      this,
    );
  }
}

abstract class _Room extends Room {
  const factory _Room(
      {required final String id,
      required final String title,
      required final String description,
      required final String roomType,
      required final int capacity,
      required final String gender,
      required final double area,
      required final int price,
      required final int deposit,
      required final int electricityCost,
      required final int waterCost,
      required final int internetCost,
      required final bool hasParking,
      required final int parkingFee,
      required final Location location,
      required final List<String> utilities,
      required final String createdByUid,
      required final String dateTime,
      required final bool isRented,
      required final String status,
      final List<String> images}) = _$_Room;
  const _Room._() : super._();

  factory _Room.fromJson(Map<String, dynamic> json) = _$_Room.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get roomType;
  @override
  int get capacity;
  @override
  String get gender;
  @override
  double get area;
  @override
  int get price;
  @override
  int get deposit;
  @override
  int get electricityCost;
  @override
  int get waterCost;
  @override
  int get internetCost;
  @override
  bool get hasParking;
  @override
  int get parkingFee;
  @override
  Location get location;
  @override
  List<String> get utilities;
  @override
  String get createdByUid;
  @override
  String get dateTime;
  @override
  bool get isRented;
  @override
  String get status;
  @override
  List<String> get images;
  @override
  @JsonKey(ignore: true)
  _$$_RoomCopyWith<_$_Room> get copyWith => throw _privateConstructorUsedError;
}
