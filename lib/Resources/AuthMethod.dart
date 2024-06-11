import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation/MODELS/FormModel.dart';
import 'package:crudoperation/MODELS/UserModel.dart';
import 'package:crudoperation/Resources/Functions.dart';

import 'package:crudoperation/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Authenticationclass {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CommonFunctions commonFunctions = CommonFunctions();
  Future<Users> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return Users.fromMap(snap as Map<String, dynamic>);
  }

  Future<String> signUpUser(
      {required String name,
      required String phone,
      required String email,
      required String address,
      required String password}) async {
    name.trim();
    phone.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (name != "" &&
        phone != "" &&
        email != "" &&
        address != "" &&
        password != "") {
      try {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String salt = BCrypt.gensalt();
        String hashedPassword = BCrypt.hashpw(password, salt);
        print(hashedPassword);
        print(cred.user!.uid);
        Users user = Users(
          lastActive: DateTime.now(),
          email: email,
          address: address,
          password: hashedPassword,
          phone: phone,
          name: name,
          uid: cred.user!.uid,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toMap());
        // await cloud().uploadUserDataToFireStore(user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up alll the fields.";
    }

    return output;
  }

  Future<void> Logout(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } catch (e) {
      print("error");
    }
  }

  Future<String> submitForm({
    required String textfiel1,
    required String textfield2,
    required String cat,
  }) async {
    String output = "Something went wrong";
    if (textfiel1 != "" && textfield2 != "" && cat != "") {
      try {
        User currentUser = FirebaseAuth.instance.currentUser!;
        double calculation = double.parse(cat);

        FormM formM = FormM(
            personID: currentUser.uid,
            time: DateTime.now(),
            serial: textfiel1,
            reason: textfield2,
            calculate: calculation);

        await FirebaseFirestore.instance
            .collection("submitForm")
            .doc(currentUser.uid)
            .set(formM.toMap());
        output = "success";
      } catch (e) {
        return e.toString();
      }
    } else {
      output = "Please fill up alll the fields.";
    }
    return output;
  }
}
