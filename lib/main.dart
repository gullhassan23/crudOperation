import 'package:crudoperation/Controller/FormController.dart';
import 'package:crudoperation/Controller/userController.dart';
import 'package:crudoperation/Screens/Home.dart';
import 'package:crudoperation/Screens/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<UserController>(UserController());
  Get.put<FormController>(FormController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => HOME()),
          ],
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                // Update the user data when auth state changes
                Get.find<UserController>().fetchUserData();
                return HOME();
              } else {
                return Splash();
              }
            },
          ),
        );
      },
    );
  }
}
