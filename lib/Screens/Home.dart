import 'package:crudoperation/Controller/FormController.dart';
import 'package:crudoperation/Controller/userController.dart';
import 'package:crudoperation/Resources/AuthMethod.dart';
import 'package:crudoperation/Resources/Functions.dart';
import 'package:crudoperation/Screens/viewScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class HOME extends StatefulWidget {
  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        surfaceTintColor: Colors.blue.shade900,
        backgroundColor: Colors.blue.shade900,
        title: Obx(
          () {
            if (userController.user.value.uid.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return Row(
                children: [
                  Text(
                    "Hello ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${userController.user.value.name.toString()}",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                ],
              );
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Authenticationclass().Logout(context);
            },
            icon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (userController.user.value.uid.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Feee(),
              ],
            ),
          );
        }
      }),
    );
  }
}

class Feee extends StatefulWidget {
  const Feee({super.key});

  @override
  State<Feee> createState() => _FeeeState();
}

class _FeeeState extends State<Feee> {
  final FormController formController = Get.put(FormController());
  TextEditingController Roll = new TextEditingController();
  TextEditingController StdN = new TextEditingController();
  final FeesForm = GlobalKey<FormState>();
  CommonFunctions cMethod = CommonFunctions();
  String roll = "";
  String std = "";
  int input = 0;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: FeesForm,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: Roll,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Serial NO.";
                  } else
                    return null;
                },
                onSaved: (value) {
                  setState(() {
                    roll = value.toString();
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  labelText: "enter Serial No.",
                  hintText: "enter your serial Number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: StdN,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Reason of leave";
                  } else
                    return null;
                },
                onSaved: (value) {
                  setState(() {
                    std = value.toString();
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  labelText: "Reason for leave",
                  hintText: "Reason for leave",
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              "Select Days",
              style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Checkbox(
                  value: monday,
                  onChanged: (bool? value) {
                    setState(() {
                      monday = value!;
                      if (monday) {
                        input = input + 100;
                      } else {
                        input = input - 100;
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Monday',
              ),
              SizedBox(width: 50),
              Checkbox(
                value: tuesday,
                onChanged: (bool? value) {
                  setState(() {
                    tuesday = value!;
                    if (tuesday) {
                      input = input + 100;
                    } else {
                      input = input - 100;
                    }
                  });
                },
              ),
              SizedBox(width: 10),
              Text(
                'Tuesday',
              ),
            ]),
            Padding(padding: EdgeInsets.only(top: 15)),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Checkbox(
                  value: wednesday,
                  onChanged: (bool? value) {
                    setState(() {
                      wednesday = value!;
                      if (wednesday) {
                        input = input + 100;
                      } else {
                        input = input - 100;
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Wednesday',
              ),
              SizedBox(width: 25),
              Checkbox(
                value: thursday,
                onChanged: (bool? value) {
                  setState(() {
                    thursday = value!;
                    if (thursday) {
                      input = input + 100;
                    } else {
                      input = input - 100;
                    }
                  });
                },
              ),
              SizedBox(width: 5),
              Text(
                'Thursday',
              ),
            ]),
            Padding(padding: EdgeInsets.only(top: 15)),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Checkbox(
                  value: friday,
                  onChanged: (bool? value) {
                    setState(() {
                      friday = value!;
                      if (friday) {
                        input = input + 100;
                      } else {
                        input = input - 100;
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Friday',
              ),
              SizedBox(width: 40),
              Checkbox(
                value: saturday,
                onChanged: (bool? value) {
                  setState(() {
                    saturday = value!;
                    if (saturday) {
                      input = input + 100;
                    } else {
                      input = input - 100;
                    }
                  });
                },
              ),
              SizedBox(width: 10),
              Text(
                'Saturday',
              ),
            ]),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      "Calculation of fine: ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Text(
                        input.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120.w,
                ),
                isSubmitted
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => UserDataScreen()));
                        },
                        child: Text(
                          'View',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontSize: 18.sp,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: ElevatedButton.icon(
                  icon: Icon(Icons.add_circle_rounded),
                  onPressed: () async {
                    if (FeesForm.currentState!.validate()) {
                      FeesForm.currentState?.save();
                      String output = await Authenticationclass().submitForm(
                          cat: input.toString(),
                          textfiel1: Roll.text,
                          textfield2: StdN.text);
                      if (output == "success") {
                        setState(() {
                          isSubmitted = true;
                        });
                        cMethod.displaYSnacKBaR(
                            "Form submit to firebase  Successfully", context);
                        formController.fetchform();
                        // transactionController.fetchBank();
                      } else {
                        cMethod.displaYSnacKBaR(output, context);
                      }
                    }
                  },
                  label: Text(' Submit')),
            )
          ],
        ));
  }
}
