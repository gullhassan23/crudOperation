import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation/MODELS/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserController extends GetxController {
  var user = Users(
    uid: '',
    lastActive: DateTime.now(),
    name: '',
    email: '',
    password: '',
    phone: '',
  ).obs;
  Users? _userModel;

  // Getter to access the user model
  Users? get userModel => _userModel;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchUserData();
      }
    });
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<String, dynamic>? data = snap.data() as Map<String, dynamic>?;
      if (data != null) {
        user.value = Users.fromMap(data);

        print("USERS ${user.value.name.toString()}");
      } else {
        print("NO USER DATA FOUND");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }
    user.refresh();
  }
}
