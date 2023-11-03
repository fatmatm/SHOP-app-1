import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Cubits/register/cubit/cubit.dart';
import '../Cubits/register/cubit/states.dart';
import 'Login.dart';
import 'home.dart';

class registerScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var phoneControler = TextEditingController();
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Register_Cubit(),
      child: BlocConsumer<Register_Cubit, register_states>(
          listener: (context, state) {
        if (state is sucsessRegister_state) {
          if (state.loginModel!.status == true)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));

          if (state.loginModel?.status == false) {
            print("فشل ");
            Fluttertoast.showToast(
                msg: state.loginModel!.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Register now to our hot offers',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DefultTextFormfiled(
                              controller: nameControler,
                              prefix: Icons.person,
                              label: Text('User Name'),
                              keyBordtype: TextInputType.name,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DefultTextFormfiled(
                              controller: phoneControler,
                              prefix: Icons.phone,
                              label: Text('Phone Number'),
                              keyBordtype: TextInputType.phone,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DefultTextFormfiled(
                              controller: emailControler,
                              prefix: Icons.email,
                              label: Text('Email'),
                              keyBordtype: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DefultTextFormfiled(
                                controller: passwordControler,
                                prefix: Icons.email,
                                label: Text('Password '),
                                obscreText:
                                    Register_Cubit.get(context).isPassword,
                                keyBordtype: TextInputType.emailAddress,
                                sufix: Register_Cubit.get(context).suffix,
                                suffixPressed: () {
                                  Register_Cubit.get(context).changeVisability();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                                condition: state is! lodingRigister_state,
                                builder: (context) => MaterialButton(
                                      onPressed: () {
                                        Register_Cubit.get(context).User_Register(
                                            name: nameControler.text,
                                            phone: phoneControler.text,
                                            email: emailControler.text,
                                            password: passwordControler.text);
                                      },
                                      child: Text(
                                        'Register',
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
