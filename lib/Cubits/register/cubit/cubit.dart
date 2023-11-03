import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/Cubits/register/cubit/states.dart';
import 'package:test_shop_app/Dio.dart';
import 'package:test_shop_app/models/Login%20Model.dart';


class Register_Cubit extends Cubit<register_states>{
  Register_Cubit():super(intialRegister_state());
  static Register_Cubit get(context)=>BlocProvider.of(context);
  shopLoginModel? loginModel;
  void User_Register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }){
    emit(lodingRigister_state());
    print('call usermaodel');
    dio_helper.postData(
        url:'register',
        data: {
          'name':name,
          'phone':phone ,
          'email':email,
          'password':password ,
        }
    )?.then((value) {
   loginModel= shopLoginModel.fromJson(value?.data);
      print(loginModel?.message);
     emit(sucsessRegister_state(loginModel!));

   print('/////////////////////////////////////////////////////////////////');

    }).catchError((error){
      emit(errorRegister_state());
    });

  }

  bool isPassword=true;

  IconData suffix=Icons.visibility_outlined;
  void changeVisability(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.image;

  }
}