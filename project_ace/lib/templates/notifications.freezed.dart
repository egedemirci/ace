// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notifications.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String get notifType => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) then) =
      _$AppNotificationCopyWithImpl<$Res>;
  $Res call({String notifType, String subjectId, DateTime createdAt});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  final AppNotification _value;
  // ignore: unused_field
  final $Res Function(AppNotification) _then;

  @override
  $Res call({
    Object? notifType = freezed,
    Object? subjectId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      notifType: notifType == freezed
          ? _value.notifType
          : notifType // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: subjectId == freezed
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_AppNotificationCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$_AppNotificationCopyWith(
          _$_AppNotification value, $Res Function(_$_AppNotification) then) =
      __$$_AppNotificationCopyWithImpl<$Res>;
  @override
  $Res call({String notifType, String subjectId, DateTime createdAt});
}

/// @nodoc
class __$$_AppNotificationCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res>
    implements _$$_AppNotificationCopyWith<$Res> {
  __$$_AppNotificationCopyWithImpl(
      _$_AppNotification _value, $Res Function(_$_AppNotification) _then)
      : super(_value, (v) => _then(v as _$_AppNotification));

  @override
  _$_AppNotification get _value => super._value as _$_AppNotification;

  @override
  $Res call({
    Object? notifType = freezed,
    Object? subjectId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_AppNotification(
      notifType: notifType == freezed
          ? _value.notifType
          : notifType // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: subjectId == freezed
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppNotification implements _AppNotification {
  const _$_AppNotification(
      {required this.notifType,
      required this.subjectId,
      required this.createdAt});

  factory _$_AppNotification.fromJson(Map<String, dynamic> json) =>
      _$$_AppNotificationFromJson(json);

  @override
  final String notifType;
  @override
  final String subjectId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AppNotification(notifType: $notifType, subjectId: $subjectId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppNotification &&
            const DeepCollectionEquality().equals(other.notifType, notifType) &&
            const DeepCollectionEquality().equals(other.subjectId, subjectId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(notifType),
      const DeepCollectionEquality().hash(subjectId),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_AppNotificationCopyWith<_$_AppNotification> get copyWith =>
      __$$_AppNotificationCopyWithImpl<_$_AppNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppNotificationToJson(this);
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification(
      {required final String notifType,
      required final String subjectId,
      required final DateTime createdAt}) = _$_AppNotification;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$_AppNotification.fromJson;

  @override
  String get notifType => throw _privateConstructorUsedError;
  @override
  String get subjectId => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AppNotificationCopyWith<_$_AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
