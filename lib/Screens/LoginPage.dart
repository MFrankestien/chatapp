import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/CustomTextField.dart';
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? pss;

  bool isloading=false;

  GlobalKey <FormState> form=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isloading,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset("assets/images/scholar.png"),
                    Text("Scholar APP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white,fontFamily: 'Pacifico'),),
                    Row(
                      children: [
                        Text("LogIn",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'Pacifico'),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    CustomTextoField(hint: "Email",
                        isPass: false,
                        onchange:(data){
                          email=data;
                          print(data);
                        }),
                    const SizedBox(height: 15,),
                    CustomTextoField(hint: "Passowrd",
                      isPass: true,
                      onchange: (data){
                        pss=data;
                        print(data);
                      },),
                    const SizedBox(height: 15,),
                    GestureDetector(
                      onTap: ()async {
                        if( form.currentState!.validate()){
                          setState(() {
                            isloading=true;
                          });

                          try {

                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email!,
                                password: pss!
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Welcome"),duration:Duration(seconds: 2),)
                            );
                          }
                          on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No user found for that email.'),duration:Duration(seconds: 2),)
                              );
                            }
                            else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Wrong password provided for that user.'),duration:Duration(seconds: 2),)
                              );
                            }
                            setState(() {
                              isloading=false;
                            });
                          }

                          print("done");
                        }
                        else{
                          print("Field");
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Center(child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Pacifico'))),
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have acc ??   ",style:TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700)),
                          Text("Register ?",style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.w700),)
                        ],
                      ),
                    )


                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
