import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat-screen.dart';
import 'package:chat_app/screens/login-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_textformfield.dart';
import '../helper/showsnackbar.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                            'Register',
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
                                await registerUser();
                                Navigator.pushReplacementNamed(context, ChatScreen.id);
                              }on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showSnackbar(context,'The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackbar(context, 'The account already exists for that email.');
                                }
                              } catch (e) {
                                showSnackbar(context, 'There was an error');
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          text: 'Register'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('already have an account?',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Login',
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

  Future<void> registerUser() async {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
