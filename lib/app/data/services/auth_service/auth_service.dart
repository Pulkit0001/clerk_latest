

import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/utils/custom_exceptions.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthRepo {


    static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void _initialize(){
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    _auth.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  AuthRepo._privateConstructor(){
    _initialize();
  }

  static final AuthRepo _instance = AuthRepo._privateConstructor();

  static AuthRepo get instance => _instance;


  Future<UserCredential> signUpViaEmail(String email, String password) async {
    try {
      UserCredential _user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _user;
    }on FirebaseAuthException catch (e){
      CustomSnackBar.show(title: "OOPS", body: e.code);

      rethrow;
    } catch(e){
      CustomSnackBar.show(title: defaultErrorTitle, body: defaultErrorBody);
      throw HandledException();
    }
  }

  Future<UserCredential> signInViaEmail(String email, String password) async {
    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _user;
    }on FirebaseAuthException catch (e){
      rethrow;
    } catch(e){
      CustomSnackBar.show(title: defaultErrorTitle, body: defaultErrorBody);
      throw HandledException();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);

  }

}

