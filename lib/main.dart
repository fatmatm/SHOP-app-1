import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/Dio.dart';
import 'package:test_shop_app/sharedPref.dart';
import 'Cubits/shopCubit/cubit.dart';
import 'Cubits/shopCubit/states.dart';
import 'constants.dart';
import 'layouts/onBording_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio_helper.init();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  print('token is=');
  print(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()
        ..GetUserData()
        ..getHomeData()
        ..getCatiegoriesData()
        ..getFavorites(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: onBordingScreen(),
          );
        },
      ),
    );
  }
}
