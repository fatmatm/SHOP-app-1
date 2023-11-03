import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/Cubits/Login/cubit/states.dart';
import 'package:test_shop_app/Dio.dart';
import 'package:test_shop_app/models/Login%20Model.dart';


class Login_Cubit extends Cubit<Login_states>{
  Login_Cubit():super(intial_state());
  static Login_Cubit get(context)=>BlocProvider.of(context);

  void User_Login({
    required String email,
    required String password,
  }){

    print('call usermaodel');
    dio_helper.postData(

        url:'login',
        data: {
          'email':email,
          'password':password ,
        }
    )?.then((value) {
    shopLoginModel loginModel= shopLoginModel.fromJson(value?.data);
      print(loginModel.message);

    emit(sucsess_state(loginModel!));
     // login_model loginModel= login_model.formjson(value?.data);
      print('/////////////////////////////////////////////////////////////////');

    });

  }

  bool isPassword=true;

  IconData suffix=Icons.visibility_outlined;
  void changeVisability(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.image;

  }
}