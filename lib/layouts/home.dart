import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/layouts/search.dart';

import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()..getHomeData(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(
                'Tola Shop',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.purple),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => searchScreen()));
                  },
                  icon: Icon(Icons.search),
                  color: Colors.purple,
                )
              ],
            ),
            body: shopCubit
                .get(context)
                .screens[shopCubit.get(context).CurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: shopCubit.get(context).CurrentIndex,
              onTap: (index) {
                shopCubit.get(context).changeCurrrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Catogries'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.discount), label: 'Offer'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.purple,
              selectedLabelStyle: TextStyle(color: Colors.purple),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              showUnselectedLabels: true,
              //fixedColor: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
