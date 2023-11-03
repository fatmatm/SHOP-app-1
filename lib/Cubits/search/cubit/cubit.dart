import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/Cubits/search/cubit/states.dart';
import 'package:test_shop_app/Dio.dart';

import '../../../models/searchmodel.dart';


class searchCubit extends Cubit<searchStates>{
  searchCubit():super(intialsearch_state());
  static searchCubit get(context)=>BlocProvider.of(context);
  late SearchModel search_model;
  void search(String text){
    emit(searchLoading_state());
    dio_helper.postData(
        url: 'products/search',
        data: {
          'text':text,

        })?.then((value){
          print('search done succesfuly');
          search_model=SearchModel.fromJson(value!.data);
          emit(searchSucses_state());

    }).catchError((error){
      emit(searchError_state());
    });
    
  }





}