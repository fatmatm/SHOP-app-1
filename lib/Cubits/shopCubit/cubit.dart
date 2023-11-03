import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/Cubits/shopCubit/states.dart';
import 'package:test_shop_app/Dio.dart';
import 'package:test_shop_app/constants.dart';
import 'package:test_shop_app/models/favioritesModel.dart';

import '../../layouts/HomeNav.dart';
import '../../layouts/categories.dart';
import '../../layouts/favoriets.dart';
import '../../layouts/offer.dart';
import '../../layouts/settings.dart';
import '../../models/categoriesModel.dart';
import '../../models/getFavorietsModel.dart';
import '../../models/homeModel.dart';
import '../../models/profileModel.dart';


class shopCubit extends Cubit<shopStates> {
  shopCubit() : super(shopIntialState());
  static shopCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;
  void changeCurrrentIndex(int index) {
    CurrentIndex = index;
    emit(shopchangeBottomNavBar());
  }

  List<Widget> screens = [
    HomeNavScreen(),
    categoriesScreen(),
    OfferScreen(),
    favorietsScreen(),
    settingsScreen(),
  ];

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int?, bool?> faivorites = {};

  void getHomeData() {
    emit(shopLoadingState());
    //print('get home Data');
    dio_helper.getData(url: 'home').then((value) {
      //print('dioHelper');
      homeModel = HomeModel.fromJson(value?.data);
      //print(homeModel!.data?.banners![0].image);
      //print('statues is =');
      //print(homeModel?.status);
      homeModel?.data?.products.forEach((element) {
        faivorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(shopSucessState());
    }).catchError((error) {
      emit(shoperrorState());
    });
  }

  ChangeFavoriets? changeFav;

  void getCatiegoriesData() {
    //print('get catiegories Data');
    dio_helper.getData(url: 'categories').then((value) {
      //print('dioHelperforcat');
      categoriesModel = CategoriesModel.fromJson(value?.data);
      // print('categories not equal null');
      //print(categoriesModel!.data?.currentPage);
      //print('statues catigories is =');
      if (categoriesModel != null) {
        //  print('not equal null');
      }
      //print(categoriesModel?.status);
      emit(shopSucessCategoriesState());
    }).catchError((error) {
      emit(shoperrorCategoriesState());
    });
  }

   FavorietsModel ?favoritesModel;

  void getFavorites() {
    emit(shopSucessFavState());

    dio_helper
        .getData(
      url: 'favorites',
      Token: token,
    )
        .then((value) {
      favoritesModel = FavorietsModel.fromJson(value!.data);
//      print(value.data.toString());
      //    print('favorites state is =');
      //  print(favoritesModel?.status);
      emit(shopSucessFavState());
    }).catchError((error) {
      //print(error.toString());
      //emit(shoperrorFavState());
    });
  }

  void changeFavoriets(int? productId) {
    faivorites[productId] = !faivorites[productId]!;
    emit(shopChangeFavvorietsState());
    dio_helper
        .postData(
      url: 'favorites',
      data: {
        'product_id': productId,
      },
      Token: token,
    )
        ?.then((value) {
      changeFav = ChangeFavoriets.fromJson(value?.data);
      //print('data is =');
      //print(value?.data);
      // print('new token');
      // print(token);
      if (changeFav?.status == false) {
        faivorites[productId] = !faivorites[productId]!;
      } else
        getFavorites();
      emit(shopSucessFavState());
      // print(faivorites.toString());
    }).catchError((error) {
      faivorites[productId] = !faivorites[productId]!;
      emit(shoperrorFavState());
    });
  }

  getUserData? userModelData;

  void GetUserData() {
    print('enter User methon');
    emit(GetUserDataLoading_state());
    dio_helper.getData(url: 'profile', Token: token).then((value) {
      userModelData = getUserData.fromJson(value?.data);
      emit(GetUserDataSucsess_state());
      print('///////////////get user name');
      print(userModelData?.data?.name);
      //    print('favorites state is =');
      //  print(favoritesModel?.status);
    }).catchError((error) {
      //print(error.toString());
      emit(GetUserDataError_state());
    });
  }
}
