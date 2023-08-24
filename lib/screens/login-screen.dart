import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login-screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_textformfield.dart';
import '../helper/showsnackbar.dart';
import 'chat-screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email,password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Spacer(),
                      Center(child: Image.asset(kLogo)),
                      Text(
                        'Selim Chat',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'pacifico'
                        ),
                      ),
                      Spacer(flex: 1,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(height: 20,),
                          CustomTextFormField(
                            isOb: false,
                            onChanged: (email1){
                              email = email1;
                            },
                            label: 'Email',
                            hint: 'enter your email', valid: 'please enter an email',
                          ),
                          SizedBox(height: 10,),
                          CustomTextFormField(
                            isOb: true,
                            onChanged: (password1){
                              password = password1;
                            },
                            hint: 'enter your password',
                            label: 'Password', valid: 'please enter a password',)
                        ],
                      ),
                      SizedBox(height: 20,),
                      CustomButton(
                          onTap: ()async{
                            setState(() {
                              isLoading = true;
                            });
                            if (formKey.currentState!.validate()) {
                              try{
                                await loginUser();
                                Navigator.pushReplacementNamed(context, ChatScreen.id, arguments: email);
                              }on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showSnackbar(context,'No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  showSnackbar(context, 'Wrong password provided for that user.');
                                }
                              } catch (e) {
                                showSnackbar(context, 'There was an error');
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          text: 'Login'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have an account? ',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, RegisterScreen.id);
                          }, child: Text('Register',
                            style: TextStyle(color: Color(0xffC7EDE6)),)),
                        ],

                      ),
                      Spacer(flex: 1,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
