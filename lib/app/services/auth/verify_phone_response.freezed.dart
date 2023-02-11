// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'verify_phone_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VerifyPhoneResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneAuthCredential credential)
        verificationCompleted,
    required TResult Function(FirebaseAuthException e) verificationFailed,
    required TResult Function(String verificationId, int? resendToken) codeSent,
    required TResult Function(String verificationId) codeAutoRetrievalTimeout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VerificationCompleted value)
        verificationCompleted,
    required TResult Function(_VerificationFailed value) verificationFailed,
    required TResult Function(_CodeSent value) codeSent,
    required TResult Function(_CodeAutoRetrievalTimeout value)
        codeAutoRetrievalTimeout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyPhoneResponseCopyWith<$Res> {
  factory $VerifyPhoneResponseCopyWith(
          VerifyPhoneResponse value, $Res Function(VerifyPhoneResponse) then) =
      _$VerifyPhoneResponseCopyWithImpl<$Res>;
}

/// @nodoc
class _$VerifyPhoneResponseCopyWithImpl<$Res>
    implements $VerifyPhoneResponseCopyWith<$Res> {
  _$VerifyPhoneResponseCopyWithImpl(this._value, this._then);

  final VerifyPhoneResponse _value;
  // ignore: unused_field
  final $Res Function(VerifyPhoneResponse) _then;
}

/// @nodoc
abstract class _$$_VerificationCompletedCopyWith<$Res> {
  factory _$$_VerificationCompletedCopyWith(_$_VerificationCompleted value,
          $Res Function(_$_VerificationCompleted) then) =
      __$$_VerificationCompletedCopyWithImpl<$Res>;
  $Res call({PhoneAuthCredential credential});
}

/// @nodoc
class __$$_VerificationCompletedCopyWithImpl<$Res>
    extends _$VerifyPhoneResponseCopyWithImpl<$Res>
    implements _$$_VerificationCompletedCopyWith<$Res> {
  __$$_VerificationCompletedCopyWithImpl(_$_VerificationCompleted _value,
      $Res Function(_$_VerificationCompleted) _then)
      : super(_value, (v) => _then(v as _$_VerificationCompleted));

  @override
  _$_VerificationCompleted get _value =>
      super._value as _$_VerificationCompleted;

  @override
  $Res call({
    Object? credential = freezed,
  }) {
    return _then(_$_VerificationCompleted(
      credential == freezed
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as PhoneAuthCredential,
    ));
  }
}

/// @nodoc

class _$_VerificationCompleted implements _VerificationCompleted {
  const _$_VerificationCompleted(this.credential);

  @override
  final PhoneAuthCredential credential;

  @override
  String toString() {
    return 'VerifyPhoneResponse.verificationCompleted(credential: $credential)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VerificationCompleted &&
            const DeepCollectionEquality()
                .equals(other.credential, credential));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(credential));

  @JsonKey(ignore: true)
  @override
  _$$_VerificationCompletedCopyWith<_$_VerificationCompleted> get copyWith =>
      __$$_VerificationCompletedCopyWithImpl<_$_VerificationCompleted>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneAuthCredential credential)
        verificationCompleted,
    required TResult Function(FirebaseAuthException e) verificationFailed,
    required TResult Function(String verificationId, int? resendToken) codeSent,
    required TResult Function(String verificationId) codeAutoRetrievalTimeout,
  }) {
    return verificationCompleted(credential);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
  }) {
    return verificationCompleted?.call(credential);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (verificationCompleted != null) {
      return verificationCompleted(credential);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VerificationCompleted value)
        verificationCompleted,
    required TResult Function(_VerificationFailed value) verificationFailed,
    required TResult Function(_CodeSent value) codeSent,
    required TResult Function(_CodeAutoRetrievalTimeout value)
        codeAutoRetrievalTimeout,
  }) {
    return verificationCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
  }) {
    return verificationCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (verificationCompleted != null) {
      return verificationCompleted(this);
    }
    return orElse();
  }
}

abstract class _VerificationCompleted implements VerifyPhoneResponse {
  const factory _VerificationCompleted(final PhoneAuthCredential credential) =
      _$_VerificationCompleted;

  PhoneAuthCredential get credential;
  @JsonKey(ignore: true)
  _$$_VerificationCompletedCopyWith<_$_VerificationCompleted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_VerificationFailedCopyWith<$Res> {
  factory _$$_VerificationFailedCopyWith(_$_VerificationFailed value,
          $Res Function(_$_VerificationFailed) then) =
      __$$_VerificationFailedCopyWithImpl<$Res>;
  $Res call({FirebaseAuthException e});
}

/// @nodoc
class __$$_VerificationFailedCopyWithImpl<$Res>
    extends _$VerifyPhoneResponseCopyWithImpl<$Res>
    implements _$$_VerificationFailedCopyWith<$Res> {
  __$$_VerificationFailedCopyWithImpl(
      _$_VerificationFailed _value, $Res Function(_$_VerificationFailed) _then)
      : super(_value, (v) => _then(v as _$_VerificationFailed));

  @override
  _$_VerificationFailed get _value => super._value as _$_VerificationFailed;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$_VerificationFailed(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as FirebaseAuthException,
    ));
  }
}

/// @nodoc

class _$_VerificationFailed implements _VerificationFailed {
  const _$_VerificationFailed(this.e);

  @override
  final FirebaseAuthException e;

  @override
  String toString() {
    return 'VerifyPhoneResponse.verificationFailed(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VerificationFailed &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$_VerificationFailedCopyWith<_$_VerificationFailed> get copyWith =>
      __$$_VerificationFailedCopyWithImpl<_$_VerificationFailed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneAuthCredential credential)
        verificationCompleted,
    required TResult Function(FirebaseAuthException e) verificationFailed,
    required TResult Function(String verificationId, int? resendToken) codeSent,
    required TResult Function(String verificationId) codeAutoRetrievalTimeout,
  }) {
    return verificationFailed(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
  }) {
    return verificationFailed?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (verificationFailed != null) {
      return verificationFailed(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VerificationCompleted value)
        verificationCompleted,
    required TResult Function(_VerificationFailed value) verificationFailed,
    required TResult Function(_CodeSent value) codeSent,
    required TResult Function(_CodeAutoRetrievalTimeout value)
        codeAutoRetrievalTimeout,
  }) {
    return verificationFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
  }) {
    return verificationFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (verificationFailed != null) {
      return verificationFailed(this);
    }
    return orElse();
  }
}

abstract class _VerificationFailed implements VerifyPhoneResponse {
  const factory _VerificationFailed(final FirebaseAuthException e) =
      _$_VerificationFailed;

  FirebaseAuthException get e;
  @JsonKey(ignore: true)
  _$$_VerificationFailedCopyWith<_$_VerificationFailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CodeSentCopyWith<$Res> {
  factory _$$_CodeSentCopyWith(
          _$_CodeSent value, $Res Function(_$_CodeSent) then) =
      __$$_CodeSentCopyWithImpl<$Res>;
  $Res call({String verificationId, int? resendToken});
}

/// @nodoc
class __$$_CodeSentCopyWithImpl<$Res>
    extends _$VerifyPhoneResponseCopyWithImpl<$Res>
    implements _$$_CodeSentCopyWith<$Res> {
  __$$_CodeSentCopyWithImpl(
      _$_CodeSent _value, $Res Function(_$_CodeSent) _then)
      : super(_value, (v) => _then(v as _$_CodeSent));

  @override
  _$_CodeSent get _value => super._value as _$_CodeSent;

  @override
  $Res call({
    Object? verificationId = freezed,
    Object? resendToken = freezed,
  }) {
    return _then(_$_CodeSent(
      verificationId == freezed
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendToken == freezed
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_CodeSent implements _CodeSent {
  const _$_CodeSent(this.verificationId, this.resendToken);

  @override
  final String verificationId;
  @override
  final int? resendToken;

  @override
  String toString() {
    return 'VerifyPhoneResponse.codeSent(verificationId: $verificationId, resendToken: $resendToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CodeSent &&
            const DeepCollectionEquality()
                .equals(other.verificationId, verificationId) &&
            const DeepCollectionEquality()
                .equals(other.resendToken, resendToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(verificationId),
      const DeepCollectionEquality().hash(resendToken));

  @JsonKey(ignore: true)
  @override
  _$$_CodeSentCopyWith<_$_CodeSent> get copyWith =>
      __$$_CodeSentCopyWithImpl<_$_CodeSent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneAuthCredential credential)
        verificationCompleted,
    required TResult Function(FirebaseAuthException e) verificationFailed,
    required TResult Function(String verificationId, int? resendToken) codeSent,
    required TResult Function(String verificationId) codeAutoRetrievalTimeout,
  }) {
    return codeSent(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
  }) {
    return codeSent?.call(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (codeSent != null) {
      return codeSent(verificationId, resendToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VerificationCompleted value)
        verificationCompleted,
    required TResult Function(_VerificationFailed value) verificationFailed,
    required TResult Function(_CodeSent value) codeSent,
    required TResult Function(_CodeAutoRetrievalTimeout value)
        codeAutoRetrievalTimeout,
  }) {
    return codeSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
  }) {
    return codeSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (codeSent != null) {
      return codeSent(this);
    }
    return orElse();
  }
}

abstract class _CodeSent implements VerifyPhoneResponse {
  const factory _CodeSent(final String verificationId, final int? resendToken) =
      _$_CodeSent;

  String get verificationId;
  int? get resendToken;
  @JsonKey(ignore: true)
  _$$_CodeSentCopyWith<_$_CodeSent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CodeAutoRetrievalTimeoutCopyWith<$Res> {
  factory _$$_CodeAutoRetrievalTimeoutCopyWith(
          _$_CodeAutoRetrievalTimeout value,
          $Res Function(_$_CodeAutoRetrievalTimeout) then) =
      __$$_CodeAutoRetrievalTimeoutCopyWithImpl<$Res>;
  $Res call({String verificationId});
}

/// @nodoc
class __$$_CodeAutoRetrievalTimeoutCopyWithImpl<$Res>
    extends _$VerifyPhoneResponseCopyWithImpl<$Res>
    implements _$$_CodeAutoRetrievalTimeoutCopyWith<$Res> {
  __$$_CodeAutoRetrievalTimeoutCopyWithImpl(_$_CodeAutoRetrievalTimeout _value,
      $Res Function(_$_CodeAutoRetrievalTimeout) _then)
      : super(_value, (v) => _then(v as _$_CodeAutoRetrievalTimeout));

  @override
  _$_CodeAutoRetrievalTimeout get _value =>
      super._value as _$_CodeAutoRetrievalTimeout;

  @override
  $Res call({
    Object? verificationId = freezed,
  }) {
    return _then(_$_CodeAutoRetrievalTimeout(
      verificationId == freezed
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CodeAutoRetrievalTimeout implements _CodeAutoRetrievalTimeout {
  const _$_CodeAutoRetrievalTimeout(this.verificationId);

  @override
  final String verificationId;

  @override
  String toString() {
    return 'VerifyPhoneResponse.codeAutoRetrievalTimeout(verificationId: $verificationId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CodeAutoRetrievalTimeout &&
            const DeepCollectionEquality()
                .equals(other.verificationId, verificationId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(verificationId));

  @JsonKey(ignore: true)
  @override
  _$$_CodeAutoRetrievalTimeoutCopyWith<_$_CodeAutoRetrievalTimeout>
      get copyWith => __$$_CodeAutoRetrievalTimeoutCopyWithImpl<
          _$_CodeAutoRetrievalTimeout>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneAuthCredential credential)
        verificationCompleted,
    required TResult Function(FirebaseAuthException e) verificationFailed,
    required TResult Function(String verificationId, int? resendToken) codeSent,
    required TResult Function(String verificationId) codeAutoRetrievalTimeout,
  }) {
    return codeAutoRetrievalTimeout(verificationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
  }) {
    return codeAutoRetrievalTimeout?.call(verificationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneAuthCredential credential)? verificationCompleted,
    TResult Function(FirebaseAuthException e)? verificationFailed,
    TResult Function(String verificationId, int? resendToken)? codeSent,
    TResult Function(String verificationId)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (codeAutoRetrievalTimeout != null) {
      return codeAutoRetrievalTimeout(verificationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VerificationCompleted value)
        verificationCompleted,
    required TResult Function(_VerificationFailed value) verificationFailed,
    required TResult Function(_CodeSent value) codeSent,
    required TResult Function(_CodeAutoRetrievalTimeout value)
        codeAutoRetrievalTimeout,
  }) {
    return codeAutoRetrievalTimeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
  }) {
    return codeAutoRetrievalTimeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VerificationCompleted value)? verificationCompleted,
    TResult Function(_VerificationFailed value)? verificationFailed,
    TResult Function(_CodeSent value)? codeSent,
    TResult Function(_CodeAutoRetrievalTimeout value)? codeAutoRetrievalTimeout,
    required TResult orElse(),
  }) {
    if (codeAutoRetrievalTimeout != null) {
      return codeAutoRetrievalTimeout(this);
    }
    return orElse();
  }
}

abstract class _CodeAutoRetrievalTimeout implements VerifyPhoneResponse {
  const factory _CodeAutoRetrievalTimeout(final String verificationId) =
      _$_CodeAutoRetrievalTimeout;

  String get verificationId;
  @JsonKey(ignore: true)
  _$$_CodeAutoRetrievalTimeoutCopyWith<_$_CodeAutoRetrievalTimeout>
      get copyWith => throw _privateConstructorUsedError;
}
