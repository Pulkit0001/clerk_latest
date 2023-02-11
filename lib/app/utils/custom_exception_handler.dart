import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CustomExceptionHandler {
  static void handle(Exception e) async {
    switch (e.runtimeType) {
      case FirebaseException:
        {
          e = e as FirebaseException;
          print("${e.message} \n ${e.stackTrace}");
          break;
        }
      case FirebaseAuthException:
        {
          e = e as FirebaseAuthException;
          CustomSnackBar.show(
              title: "ERROR CODE :  ${e.code}", body: " ${e.message}");
          print("${e.message} \n ${e.stackTrace}");
          break;
        }
      default:
        {
          CustomSnackBar.show(title: "ERROR", body: " ${e.toString()}");
        }
    }
  }
}
