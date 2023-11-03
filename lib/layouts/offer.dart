import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';


class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (
        BuildContext context,
      ) =>
          shopCubit()..getHomeData(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (shopCubit.get(context).homeModel != null) {
            return ListView.separated(
                itemBuilder: (context, index) => ListproduectItemOffer(
                    shopCubit.get(context).homeModel?.data?.products[index],
                    context,
                    index),
                separatorBuilder: (context, index) => SizedBox(
                      width: 0,
                    ),
                itemCount:
                    shopCubit.get(context).homeModel!.data!.products.length);
            ();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Icon icon = Icon(Icons.favorite, color: Colors.grey);
Widget ListproduectItemOffer(model, context, index) => Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (shopCubit.get(context).homeModel != null)
                  if ((model.discount != 0))
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
                                backgroundColor: Colors.red,
                                color: Colors.white),
                          )
                      ],
                    ),
                if ((model.discount != 0))
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
                                  shopCubit
                                      .get(context)
                                      .changeFavoriets(model.id);
                                  print(shopCubit
                                      .get(context)
                                      .faivorites[model.id]);
                                },
                                icon: Icon(Icons.favorite),
                                color: (shopCubit
                                            .get(context)
                                            .faivorites[model.id] ==
                                        true)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 0,
            )
          ],
        ),
      ),
    );
