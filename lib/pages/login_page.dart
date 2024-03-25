import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread_new/controller/login_controller.dart';

class LoginScreenBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<LoginController>(LoginController());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _loginCtrl = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  controller: _loginCtrl.emailController,
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
                  controller: _loginCtrl.passwordController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _loginCtrl.login,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder()),
                  child: const Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ),
              const Divider(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont't have an account yet? "),
                  TextButton(
                      onPressed: (){
                        Get.offAndToNamed('/signUp', );
                      },
                      child: const Text(
                        "Sign up",
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
    );;
  }
}
