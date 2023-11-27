import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geogrcy_firebase/consts/contss.dart';
import 'package:geogrcy_firebase/screens/btm_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geogrcy_firebase/services/global_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Auth = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    getUserData();
  }
  bool isLoadingforgetpassword = false;
  void forgetPassFCT(String? email, context) async {
    isLoadingforgetpassword = true;

    try {
      await authInstance.sendPasswordResetEmail(email: email!.toLowerCase());
      Fluttertoast.showToast(
        msg: "An email has been sent to your email address",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseException catch (error) {
      GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);

      isLoadingforgetpassword = false;
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);

      isLoadingforgetpassword = false;
    } finally {
      isLoadingforgetpassword = false;
    }
    notifyListeners();
  }

  bool isLoadingLogin = false;
  void submitFormOnLogin({String? email, String? password, context}) async {
    FocusScope.of(context).unfocus();

    isLoadingLogin = true;

    try {
      await authInstance.signInWithEmailAndPassword(
          email: email!.toLowerCase().trim(), password: password!.trim());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomBarScreen(),
        ),
      );
      print('Succefully logged in');
    } on FirebaseException catch (error) {
      GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);

      isLoadingLogin = false;
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);

      isLoadingLogin = false;
    } finally {
      isLoadingLogin = false;
    }
    notifyListeners();
  }

  String? email;
  String? name;
  String? address;
  String? addressformfiled;
  bool isLoading = false;
  final User? user = authInstance.currentUser;

  Future<void> getUserData() async {
    isLoading = true;

    if (user == null) {
      isLoading = false;

      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        email = userDoc.get('email');
        name = userDoc.get('name');
        address = userDoc.get('shipping-address');
        addressformfiled = userDoc.get('shipping-address');
      }
    } catch (error) {
      isLoading = false;

      // GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  bool isLoadingregester = false;
  void submitFormOnRegister(
      {String? email,
      String? password,
      String? address,
      String? name,
      context}) async {
    isLoadingregester = true;

    try {
      await authInstance.createUserWithEmailAndPassword(
          email: email!.toLowerCase().trim(), password: password!.trim());
      final User? user = authInstance.currentUser;
      final _uid = user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'name': name!,
        'email': email.toLowerCase(),
        'shipping-address': address,
        'userWish': [],
        'userCart': [],
        'createdAt': Timestamp.now(),
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const BottomBarScreen(),
      ));
      print('Succefully registered');
    } on FirebaseException catch (error) {
      GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);

      isLoadingregester = false;
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);

      isLoadingregester = false;
    } finally {
      isLoadingregester = false;
    }
    notifyListeners();
  }
}
