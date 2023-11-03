import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_shop_app/layouts/register.dart';
import 'package:test_shop_app/sharedPref.dart';
import '../Cubits/Login/cubit/cubit.dart';
import '../Cubits/Login/cubit/states.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Login_Cubit(),
      child: BlocConsumer<Login_Cubit, Login_states>(
        listener: (context, state) {
          if (state is sucsess_state) {
            if (state.loginModel.status == true) {
              print(state.loginModel.status);
              print('تم بنجاح');
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }).catchError((error) {});
            }
            if (state.loginModel.status == false) {
              print("فشل ");
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, states) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Login now to our hot offers',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          DefultTextFormfiled(
                            controller: emailControler,
                            prefix: Icons.email,
                            label: Text('email address'),
                            keyBordtype: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          DefultTextFormfiled(
                              controller: passwordControler,
                              prefix: Icons.email,
                              label: Text('password address'),
                              obscreText: Login_Cubit.get(context).isPassword,
                              keyBordtype: TextInputType.emailAddress,
                              sufix: Login_Cubit.get(context).suffix,
                              suffixPressed: () {
                                Login_Cubit.get(context).changeVisability();
                              }),
                          SizedBox(
                            height: 35,
                          ),
                          ConditionalBuilder(
                              condition: states is! loding_state,
                              builder: (context) => MaterialButton(
                                    onPressed: () {
                                      Login_Cubit.get(context).User_Login(
                                          email: emailControler.text,
                                          password: passwordControler.text);
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    color: Colors.purple,
                                    minWidth: double.infinity,
                                  ),
                              fallback: (context) =>
                                  CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account '),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (contex) =>
                                                  registerScreen()));
                                    },
                                    child: Text(
                                      'Register now',
                                      style: TextStyle(color: Colors.purple),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget DefultTextFormfiled({
  required TextInputType keyBordtype,
  required TextEditingController controller,
  required Text label,
  required IconData prefix,
  Function? suffixPressed,
  IconData? sufix,
  bool obscreText = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyBordtype,
      obscureText: obscreText,
      decoration: InputDecoration(
        label: label,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.grey),
        prefixIconColor: Colors.purple,
        prefixIcon: Icon(prefix),
      ),
    );
