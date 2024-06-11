import 'package:crudoperation/Resources/AuthMethod.dart';
import 'package:crudoperation/Resources/Functions.dart';
import 'package:crudoperation/Screens/Home.dart';
import 'package:crudoperation/Screens/SignUp.dart';
import 'package:crudoperation/Widgets/Textforms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool visiblePassword = false;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CommonFunctions cMethod = CommonFunctions();

  bool isLoad = false;

  @override
  void dispose() {
    super.dispose();

    emmail.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);
    // User? currentUser = auth.currentUser!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130.h, // Use ScreenUtil for height
            ),
            Center(
              child: Text("User",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34.sp)), // Use ScreenUtil for font size
            ),
            SizedBox(
              height: 30.h, // Use ScreenUtil for height
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextForm(
                        isPass: false,
                        textEditingController: emmail,
                        hintText: "email",
                        textInputType: TextInputType.emailAddress),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 38,
                        top: 20,
                        right: 38,
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visiblePassword = !visiblePassword;
                                });
                              },
                              icon: Icon(visiblePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: "Password",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: Divider.createBorderSide(context)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: Divider.createBorderSide(context)),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: !visiblePassword,
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForGoTpaSSwoRD()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 40.w, top: 5.h),
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ))
                  ],
                )),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil()
                          .setWidth(80), // Make horizontal padding responsive
                      vertical: ScreenUtil().setHeight(10),
                    )),
                onPressed: () async {
                  setState(() {
                    isLoad = true;
                  });

                  String output = await Authenticationclass()
                      .signInUser(email: emmail.text, password: password.text);
                  setState(() {
                    isLoad = false;
                  });
                  if (output == "success") {
                    //functions
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HOME()));
                  } else {
                    //error
                    cMethod.displaYSnacKBaR(output, context);
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 20.h,
            ),
          
            SizedBox(
              height: 160.h,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do you have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
