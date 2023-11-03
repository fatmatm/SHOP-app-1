import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';


class favorietsScreen extends StatelessWidget {
  const favorietsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()..getFavorites(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (shopCubit.get(context).favoritesModel != null) {
            return ListView.separated(
                itemBuilder: (context, index) => ListproduectItem(
                    shopCubit
                        .get(context)
                        .favoritesModel
                        ?.data
                        ?.data[index]
                        .product,
                    context,
                    index),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                itemCount:
                    shopCubit.get(context).favoritesModel!.data!.data.length);
            ();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Widget ListproduectItem(model, context, index) => Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (shopCubit.get(context).favoritesModel != null)
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model?.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if (model.discount != 0)
                    Text(
                      'discound',
                      style: TextStyle(
                          backgroundColor: Colors.red, color: Colors.white),
                    )
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 120,
                height: 120,
                child: Column(
                  children: [
                    Text(
                      '${model!.name}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1, fontSize: 17),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model!.price.round()}',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model!.oldPrice.round()}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                height: 1.4,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            shopCubit.get(context).changeFavoriets(model.id);

                            print(shopCubit.get(context).faivorites[model.id]);
                          },
                          icon: Center(child: Icon(Icons.favorite)),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
