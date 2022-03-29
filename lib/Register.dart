import 'package:appchat/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Widgets/CustomTextField.dart';
class Register extends StatelessWidget {

String? email;
String? pss;
bool isloading=false;
GlobalKey <FormState> form=GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
        Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'Pacifico'),),
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
            try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email!,
                  password: pss!
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome"),duration:Duration(seconds: 2),)
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Try again"),duration:Duration(seconds: 2),)
                );
                print('The account already exists for that email.');
              }
            } catch (e) {

              print(e);
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
        child: Center(child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Pacifico'))),
        ),
        ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => LoginPage(),));

            },
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have acc ??   ",style:TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700)),
                Text("Login ?",style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.w700),)
              ],
            ),
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
