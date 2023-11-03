import 'package:flutter/material.dart';
import 'Cubits/shopCubit/cubit.dart';

dynamic ? token='';
bool color=false;
bool? color_value;
Widget ListproduectItem(model,context,index)=> Container(
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
              Image(image: NetworkImage('${model?.image}'),
                width: 120,
                height: 120,

              ),
              if (model.discount != 0)
                Text('discound',style: TextStyle(backgroundColor: Colors.red,color: Colors.white),)
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            width: 120,
            height: 120,
            child: Column(

              children: [
                Text('${model!.name}', maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1,fontSize: 17),),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model!.price}',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          height: 1.4,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10,),
                    if (model.discount != 0)
                      Text(
                        '${model!.oldPrice}',
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

                        print(
                            shopCubit.get(context).faivorites[model.id]);
                      },
                      icon: Center(child: Icon(Icons.favorite)),
                      color:Colors.red,
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