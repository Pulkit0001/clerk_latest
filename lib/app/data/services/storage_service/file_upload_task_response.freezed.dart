// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'file_upload_task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FileUploadTaskResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskSnapshot snapshot) snapshot,
    required TResult Function(String errorCode) onError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Snapshot value) snapshot,
    required TResult Function(_OnError value) onError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileUploadTaskResponseCopyWith<$Res> {
  factory $FileUploadTaskResponseCopyWith(FileUploadTaskResponse value,
          $Res Function(FileUploadTaskResponse) then) =
      _$FileUploadTaskResponseCopyWithImpl<$Res>;
}

/// @nodoc
class _$FileUploadTaskResponseCopyWithImpl<$Res>
    implements $FileUploadTaskResponseCopyWith<$Res> {
  _$FileUploadTaskResponseCopyWithImpl(this._value, this._then);

  final FileUploadTaskResponse _value;
  // ignore: unused_field
  final $Res Function(FileUploadTaskResponse) _then;
}

/// @nodoc
abstract class _$$_SnapshotCopyWith<$Res> {
  factory _$$_SnapshotCopyWith(
          _$_Snapshot value, $Res Function(_$_Snapshot) then) =
      __$$_SnapshotCopyWithImpl<$Res>;
  $Res call({TaskSnapshot snapshot});
}

/// @nodoc
class __$$_SnapshotCopyWithImpl<$Res>
    extends _$FileUploadTaskResponseCopyWithImpl<$Res>
    implements _$$_SnapshotCopyWith<$Res> {
  __$$_SnapshotCopyWithImpl(
      _$_Snapshot _value, $Res Function(_$_Snapshot) _then)
      : super(_value, (v) => _then(v as _$_Snapshot));

  @override
  _$_Snapshot get _value => super._value as _$_Snapshot;

  @override
  $Res call({
    Object? snapshot = freezed,
  }) {
    return _then(_$_Snapshot(
      snapshot == freezed
          ? _value.snapshot
          : snapshot // ignore: cast_nullable_to_non_nullable
              as TaskSnapshot,
    ));
  }
}

/// @nodoc

class _$_Snapshot implements _Snapshot {
  const _$_Snapshot(this.snapshot);

  @override
  final TaskSnapshot snapshot;

  @override
  String toString() {
    return 'FileUploadTaskResponse.snapshot(snapshot: $snapshot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Snapshot &&
            const DeepCollectionEquality().equals(other.snapshot, snapshot));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(snapshot));

  @JsonKey(ignore: true)
  @override
  _$$_SnapshotCopyWith<_$_Snapshot> get copyWith =>
      __$$_SnapshotCopyWithImpl<_$_Snapshot>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskSnapshot snapshot) snapshot,
    required TResult Function(String errorCode) onError,
  }) {
    return snapshot(this.snapshot);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
  }) {
    return snapshot?.call(this.snapshot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
    required TResult orElse(),
  }) {
    if (snapshot != null) {
      return snapshot(this.snapshot);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Snapshot value) snapshot,
    required TResult Function(_OnError value) onError,
  }) {
    return snapshot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
  }) {
    return snapshot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
    required TResult orElse(),
  }) {
    if (snapshot != null) {
      return snapshot(this);
    }
    return orElse();
  }
}

abstract class _Snapshot implements FileUploadTaskResponse {
  const factory _Snapshot(final TaskSnapshot snapshot) = _$_Snapshot;

  TaskSnapshot get snapshot;
  @JsonKey(ignore: true)
  _$$_SnapshotCopyWith<_$_Snapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_OnErrorCopyWith<$Res> {
  factory _$$_OnErrorCopyWith(
          _$_OnError value, $Res Function(_$_OnError) then) =
      __$$_OnErrorCopyWithImpl<$Res>;
  $Res call({String errorCode});
}

/// @nodoc
class __$$_OnErrorCopyWithImpl<$Res>
    extends _$FileUploadTaskResponseCopyWithImpl<$Res>
    implements _$$_OnErrorCopyWith<$Res> {
  __$$_OnErrorCopyWithImpl(_$_OnError _value, $Res Function(_$_OnError) _then)
      : super(_value, (v) => _then(v as _$_OnError));

  @override
  _$_OnError get _value => super._value as _$_OnError;

  @override
  $Res call({
    Object? errorCode = freezed,
  }) {
    return _then(_$_OnError(
      errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_OnError implements _OnError {
  const _$_OnError(this.errorCode);

  @override
  final String errorCode;

  @override
  String toString() {
    return 'FileUploadTaskResponse.onError(errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnError &&
            const DeepCollectionEquality().equals(other.errorCode, errorCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(errorCode));

  @JsonKey(ignore: true)
  @override
  _$$_OnErrorCopyWith<_$_OnError> get copyWith =>
      __$$_OnErrorCopyWithImpl<_$_OnError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskSnapshot snapshot) snapshot,
    required TResult Function(String errorCode) onError,
  }) {
    return onError(errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
  }) {
    return onError?.call(errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskSnapshot snapshot)? snapshot,
    TResult Function(String errorCode)? onError,
    required TResult orElse(),
  }) {
    if (onError != null) {
      return onError(errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Snapshot value) snapshot,
    required TResult Function(_OnError value) onError,
  }) {
    return onError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
  }) {
    return onError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Snapshot value)? snapshot,
    TResult Function(_OnError value)? onError,
    required TResult orElse(),
  }) {
    if (onError != null) {
      return onError(this);
    }
    return orElse();
  }
}

abstract class _OnError implements FileUploadTaskResponse {
  const factory _OnError(final String errorCode) = _$_OnError;

  String get errorCode;
  @JsonKey(ignore: true)
  _$$_OnErrorCopyWith<_$_OnError> get copyWith =>
      throw _privateConstructorUsedError;
}
