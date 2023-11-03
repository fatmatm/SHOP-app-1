import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categoriesModel.dart';
import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contex) => shopCubit()..getCatiegoriesData(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = shopCubit.get(context);
          if (cubit.categoriesModel != null) {
            return ListView.separated(
              itemBuilder: (context, index) =>
                  CategoriesItem(cubit.categoriesModel!.data!.data![index]),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.black12,
              ),
              itemCount: cubit.categoriesModel!.data!.data!.length,
            );
          } else {
            // Handle the case when categoriesModel is null
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget CategoriesItem(DataModel data) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(data.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            data.name!,
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
