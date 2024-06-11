import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation/MODELS/FormModel.dart';
import 'package:crudoperation/Resources/Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  var form =
      FormM(time: DateTime.now(), serial: '', reason: '', calculate: 0.0).obs;
  FormM? _formM;

  FormM? get subForm => _formM;
  CommonFunctions commonFunctions = CommonFunctions();
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchform();
    });
  }

  Future<void> fetchform() async {
    try {
      // User currentUser = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('submitForm')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        form.value = FormM.fromMap(data);
        print("Current fine ${form.value.calculate.toString()}");
      } else {
        print("You have no fine");
      }
    } catch (e) {
      Get.snackbar('Fine Error', e.toString());
      print(e.toString());
    }
    form.refresh();
  }

  void updateForm(String id, String reason) {
    form.update((val) {
      if (val != null && val.personID == id) {
        val.reason = reason;
      }
    });
  }

  void removeForm(String id) {
    if (form.value.personID == id) {
      form.value = FormM(
        personID: '',
        time: DateTime.now(),
        serial: '',
        reason: '',
        calculate: 0.0,
      );
    }
  }
}
