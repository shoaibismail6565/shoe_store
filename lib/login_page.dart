import 'package:flutter/material.dart';
import 'package:shoe_store/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool isPasswordhidden=true;
  final GlobalKey<FormState> formkey=GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(24),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/logo.jpg'),
                  SizedBox(height: 8,),
                  Text('Login to continue',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  TextFormField(
                    validator: (value) => value==null || value.trim().isEmpty ?'Email is required' :null,
                    decoration: InputDecoration(
                      icon: CircleAvatar(
                         child: Icon(Icons.person),
                      ),
                          labelText: 'Email Address',
                      hintText: 'Enter your email address',
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    validator: (value) => value==null || value.trim().isEmpty ? 'Password is required' : (value.trim().length < 6 ? 'Password must contain at least 6 characters': null),
                    obscureText: isPasswordhidden,
                    decoration: InputDecoration(
                      icon: CircleAvatar(
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(onPressed: (){
                       setState(() {
                         isPasswordhidden=!isPasswordhidden;
                       });
                      }, icon: Icon(isPasswordhidden? Icons.visibility_off : Icons.visibility)),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  SizedBox(height: 16,),
                  Align(alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {
            
                    }, child: Text('Forgot Password?')),
                  ),
                  SizedBox(height: 16,),
                  PrimaryButton(label: 'Login',onPressed: (){
                    if(formkey.currentState!.validate()){
                      
                    }
                  },),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an Account?'),
                      TextButton(onPressed: () {}, child: Text('Signup'))
                    ],
                  )
            
                ],
            ),
          ),),
        ),
      ),
    );
  }
}
