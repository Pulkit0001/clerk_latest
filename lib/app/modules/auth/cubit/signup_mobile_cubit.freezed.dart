// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signup_mobile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpMobileState {
  EVerifyMobileState get estate => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  UserCredential? get credential => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpMobileStateCopyWith<SignUpMobileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpMobileStateCopyWith<$Res> {
  factory $SignUpMobileStateCopyWith(
          SignUpMobileState value, $Res Function(SignUpMobileState) then) =
      _$SignUpMobileStateCopyWithImpl<$Res>;
  $Res call(
      {EVerifyMobileState estate,
      String message,
      String countryCode,
      UserCredential? credential});
}

/// @nodoc
class _$SignUpMobileStateCopyWithImpl<$Res>
    implements $SignUpMobileStateCopyWith<$Res> {
  _$SignUpMobileStateCopyWithImpl(this._value, this._then);

  final SignUpMobileState _value;
  // ignore: unused_field
  final $Res Function(SignUpMobileState) _then;

  @override
  $Res call({
    Object? estate = freezed,
    Object? message = freezed,
    Object? countryCode = freezed,
    Object? credential = freezed,
  }) {
    return _then(_value.copyWith(
      estate: estate == freezed
          ? _value.estate
          : estate // ignore: cast_nullable_to_non_nullable
              as EVerifyMobileState,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      credential: credential == freezed
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as UserCredential?,
    ));
  }
}

/// @nodoc
abstract class _$$_SignUpMobileStateCopyWith<$Res>
    implements $SignUpMobileStateCopyWith<$Res> {
  factory _$$_SignUpMobileStateCopyWith(_$_SignUpMobileState value,
          $Res Function(_$_SignUpMobileState) then) =
      __$$_SignUpMobileStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {EVerifyMobileState estate,
      String message,
      String countryCode,
      UserCredential? credential});
}

/// @nodoc
class __$$_SignUpMobileStateCopyWithImpl<$Res>
    extends _$SignUpMobileStateCopyWithImpl<$Res>
    implements _$$_SignUpMobileStateCopyWith<$Res> {
  __$$_SignUpMobileStateCopyWithImpl(
      _$_SignUpMobileState _value, $Res Function(_$_SignUpMobileState) _then)
      : super(_value, (v) => _then(v as _$_SignUpMobileState));

  @override
  _$_SignUpMobileState get _value => super._value as _$_SignUpMobileState;

  @override
  $Res call({
    Object? estate = freezed,
    Object? message = freezed,
    Object? countryCode = freezed,
    Object? credential = freezed,
  }) {
    return _then(_$_SignUpMobileState(
      estate: estate == freezed
          ? _value.estate
          : estate // ignore: cast_nullable_to_non_nullable
              as EVerifyMobileState,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      credential: credential == freezed
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as UserCredential?,
    ));
  }
}

/// @nodoc

class _$_SignUpMobileState implements _SignUpMobileState {
  const _$_SignUpMobileState(
      {required this.estate,
      required this.message,
      required this.countryCode,
      this.credential});

  @override
  final EVerifyMobileState estate;
  @override
  final String message;
  @override
  final String countryCode;
  @override
  final UserCredential? credential;

  @override
  String toString() {
    return 'SignUpMobileState(estate: $estate, message: $message, countryCode: $countryCode, credential: $credential)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignUpMobileState &&
            const DeepCollectionEquality().equals(other.estate, estate) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.countryCode, countryCode) &&
            const DeepCollectionEquality()
                .equals(other.credential, credential));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(estate),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(countryCode),
      const DeepCollectionEquality().hash(credential));

  @JsonKey(ignore: true)
  @override
  _$$_SignUpMobileStateCopyWith<_$_SignUpMobileState> get copyWith =>
      __$$_SignUpMobileStateCopyWithImpl<_$_SignUpMobileState>(
          this, _$identity);
}

abstract class _SignUpMobileState implements SignUpMobileState {
  const factory _SignUpMobileState(
      {required final EVerifyMobileState estate,
      required final String message,
      required final String countryCode,
      final UserCredential? credential}) = _$_SignUpMobileState;

  @override
  EVerifyMobileState get estate;
  @override
  String get message;
  @override
  String get countryCode;
  @override
  UserCredential? get credential;
  @override
  @JsonKey(ignore: true)
  _$$_SignUpMobileStateCopyWith<_$_SignUpMobileState> get copyWith =>
      throw _privateConstructorUsedError;
}
