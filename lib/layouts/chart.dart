import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';



class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>shopCubit()..GetUserData(),
      child: BlocConsumer<shopCubit,shopStates>(
        listener: (context,state){},
        builder: (context,state){
          String? email = shopCubit.get(context).userModelData?.data?.email;

          if (email != null) {
            // Use the name property here.
          } else {
            // The name property is null.
          }
          return Column(
            children: [
              Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 20,
                    ),
                    if (email != null)
                      Text('${email}',style: TextStyle(fontSize: 20),)
                    else if(email==null)
                      Text('null',style: TextStyle(fontSize: 20),)
                  ]
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 20,
                  ),
                  Text('ss',style: TextStyle(fontSize: 20),)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 20,
                  ),
                  Text('dfgs',style: TextStyle(fontSize: 20),)
                ],
              ),

            ],
          );
        },

      ),
    );
  }
}
