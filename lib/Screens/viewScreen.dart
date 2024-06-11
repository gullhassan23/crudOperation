import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation/Controller/FormController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  TextEditingController editReason = TextEditingController();

  final FormController formController = Get.put(FormController());
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  User currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("USER DATA"),
      ),
      body: Obx(() {
        if (formController.form.value.serial == "") {
          return Center(
            child: Text("Your data deleted successfully"),
          );
        } else {
          return Column(
            children: [
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Obx(
                        () => Text(
                          " Serial No.  ${formController.form.value.serial.toString()}",
                        ),
                      ),
                      subtitle: Obx(
                        () => Column(
                          children: [
                            Text(
                              " Reason of leave  ${formController.form.value.reason.toString()}",
                            ),
                            Text(
                              "Calculate fine  ${formController.form.value.calculate.toString()}",
                            )
                          ],
                        ),
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),
                              )),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                // onTap: () async {
                                //   await FirebaseFirestore.instance
                                //       .collection('submitForm')
                                //       .doc(FirebaseAuth.instance.currentUser!.uid)
                                //       .delete();
                                //   print('delete successfully');

                                //   Navigator.pop(context);
                                // },
                                leading: Icon(Icons.delete),
                                title: Text("Delete"),
                              )),
                        ],
                        icon: Icon(Icons.more_horiz),
                        onSelected: (value) {
                          if (value == 1) {
                            ShowMyDialog(
                                formController.form.value.reason.toString());
                          } else if (value == 2) {
                            _deleteEntry(formController.form.value.personID);
                          }
                        },
                      ));
                },
              )
            ],
          );
        }
      }),
    );
  }

  void ShowMyDialog(String reason) async {
    editReason.text = reason;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("update"),
            content: Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: editReason,
                    decoration: InputDecoration(
                        label: Text("Reason"), hintText: "Edit Reason"),
                  ),
                ],
              ),
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    FirebaseFirestore.instance
                        .collection('submitForm')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'reason': editReason.text,
                    }).then((_) {
                      formController.updateForm(
                          currentUser.uid, editReason.text);
                    });
                    // firebase
                    //     .collection("users")
                    //     .doc(currentUser.uid)
                    //     .collection("submiForm")
                    //     .doc(currentUser.uid)
                    //     .update({
                    //   'reason': editReason.text,
                    // });
                  },
                  child: Text("Update")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}

void _deleteEntry(String id) async {
  final FormController formController = Get.put(FormController());
  await FirebaseFirestore.instance
      .collection('submitForm')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .delete();
  formController.removeForm(id);
  print('delete successfully');
}
