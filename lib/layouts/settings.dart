import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../sharedPref.dart';
import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';
import 'Login.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()..GetUserData(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String? name = shopCubit.get(context).userModelData?.data?.name;
          String? phone = shopCubit.get(context).userModelData?.data?.phone;
          String? email = shopCubit.get(context).userModelData?.data?.email;
          String? image = shopCubit.get(context).userModelData?.data?.image;

          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    if (image != null)
                      Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60)),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
                              ),
                              height: 150,
                              width: 150,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (name != null)
                              Text(
                                '${name}',
                                style: TextStyle(fontSize: 25),
                              )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        if (phone != null)
                          Text(
                            '${phone}',
                            style: TextStyle(fontSize: 20),
                          )
                        else if (phone == null)
                          Text(
                            'null',
                            style: TextStyle(fontSize: 20),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.purple),
                        SizedBox(
                          width: 20,
                        ),
                        if (email != null)
                          Text(
                            '${email}',
                            style: TextStyle(fontSize: 20),
                          )
                        else if (email == null)
                          Text(
                            'null',
                            style: TextStyle(fontSize: 20),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                      onPressed: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          print('remove token');
                          if (value == true)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                        });
                      },
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      color: Colors.purple,
                      minWidth: double.infinity,
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
