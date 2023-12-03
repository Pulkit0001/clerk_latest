part of 'app_cubit.dart';

enum EAppState {
  loggedIn,
  loggedOut,
  pendingAccount,
  notDetermined,
}

const _$EAppStateTypeMap = {EAppState.loggedIn: 'loggedIn'};

extension EAppStateHelper on EAppState {
  String? encode() => _$EAppStateTypeMap[this];

  EAppState key(String value) => decodeEAppState(value);

  EAppState decodeEAppState(String value) {
    return _$EAppStateTypeMap.entries
        .singleWhere((element) => element.value == value)
        .key;
  }

  T when<T>({
    required T Function() loggedIn,
    required T Function() loggedOut,
    required T Function() pendingAccount,
    required T Function() notDetermined,
  }) {
    switch (this) {
      case EAppState.loggedIn:
        return loggedIn.call();
      case EAppState.loggedOut:
        return loggedOut.call();
      case EAppState.pendingAccount:
        return pendingAccount.call();
      case EAppState.notDetermined:
        return notDetermined.call();
      // ignore: no_default_cases
      default:
    }
    throw Exception('Invalid EAppState');
  }

  T mayBeWhen<T>({
    required T Function() elseMaybe,
    T Function()? loggedIn,
    T Function()? loggedOut,
    T Function()? pendingAccount,
    T Function()? notDetermined,
  }) {
    switch (this) {
      case EAppState.loggedIn:
        if (loggedIn != null) {
          return loggedIn.call();
        } else {
          return elseMaybe();
        }
      case EAppState.loggedOut:
        if (loggedOut != null) {
          return loggedOut.call();
        } else {
          return elseMaybe();
        }
      case EAppState.notDetermined:
        if (notDetermined != null) {
          return notDetermined.call();
        } else {
          return elseMaybe();
        }
      case EAppState.pendingAccount:
        if (pendingAccount != null) {
          return pendingAccount.call();
        } else {
          return elseMaybe();
        }
      // ignore: no_default_cases
      default:
        return elseMaybe();
    }
  }
}
