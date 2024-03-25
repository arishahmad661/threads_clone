import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreenBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<SignUpController>(SignUpController());

  }
}

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _signUpctrl = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Image.asset('assets/thread_logo.png', width: 80,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _signUpctrl.emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Enter you email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _signUpctrl.passwordController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Enter you password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _signUpctrl.nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _signUpctrl.userNameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _signUpctrl.signUp,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder()),
                        child: const Text("Sign up", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                          onPressed: (){
                            Get.offAndToNamed('/login');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
