import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_shop_app/models/categoriesModel.dart';
import 'package:test_shop_app/models/homeModel.dart';

import '../Cubits/shopCubit/cubit.dart';
import '../Cubits/shopCubit/states.dart';


class HomeNavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()
        ..getHomeData()
        ..getCatiegoriesData()
        ..getFavorites(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: shopCubit.get(context).homeModel != null,
              builder: (context) => productsBuilder(
                  shopCubit.get(context).homeModel,
                  shopCubit.get(context).categoriesModel,
                  context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

Widget productsBuilder(HomeModel? model, CategoriesModel? catModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: CarouselSlider(
              items: model?.data?.banners
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  initialPage: 0,
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  viewportFraction: 0.85),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.purple),
            ),
          ),
          Container(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CatigouriesList(
                  shopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                width: 4,
              ),
              itemCount:
                  shopCubit.get(context).categoriesModel!.data.data.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.purple),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1 / 1.66,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model!.data!.products.length,
                (index) => BuildGridProduct(
                    model!.data!.products[index], context, index),
              ),
            ),
          ),
        ],
      ),
    );
Widget BuildGridProduct(ProductModel model, context, index) => Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ConditionalBuilder(
                  condition: model.image != null,
                  builder: (context) => Image(
                    image: NetworkImage('${model.image}'),
                    width: double.infinity,
                    height: 200,
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                if (model.discount != 0)
                  Container(
                    width: 59,
                    height: 13,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    color: Colors.red,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.0),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            height: 1.3,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      if (model.id != 0)
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                shopCubit
                                    .get(context)
                                    .changeFavoriets(model.id);
                                print(shopCubit
                                    .get(context)
                                    .faivorites[model.id]);
                              },
                              icon: Center(child: Icon(Icons.favorite)),
                              color: (shopCubit
                                          .get(context)
                                          .faivorites[model.id] ==
                                      true)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
Widget CatigouriesList(DataModel dataModel) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${dataModel.image}'),
                  // fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                Container(
                    color: Colors.black54,
                    width: 100,
                    child: Center(
                        child: Text(
                      dataModel.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                    ))),
              ],
            ),
          ),
        ),
      ],
    );
