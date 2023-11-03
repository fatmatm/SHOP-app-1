import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/search/cubit/cubit.dart';
import '../Cubits/search/cubit/states.dart';


class searchScreen extends StatelessWidget {
  @override

   var formKey=GlobalKey<FormState>();
   var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>searchCubit(),
      child: BlocConsumer<searchCubit,searchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Search',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              backgroundColor: Colors.green,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType:  TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      label:  Text('Search'),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      prefixIconColor: Colors.green,
                      prefixIcon:Icon(
                          Icons.search
                      ),




                    ),
                    onFieldSubmitted:(String text){
                      searchCubit.get(context).search(text);
                    },

                  ),
                    SizedBox(height: 20,),
                    if(state is searchLoading_state)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                  if(state is searchSucses_state ==true)
                    Expanded(
                      child: ListView.separated(
                itemBuilder: (context,index)=>ListproduectItem(searchCubit.get(context).search_model.data?.data[index] ,context,index),
                separatorBuilder: (context,index)=> Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.black12,
                ),
                itemCount: searchCubit.get(context).search_model.data!.data.length,
                  ),
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
Widget ListproduectItem(model,context,index)=> Container(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (searchCubit.get(context).search_model != null)
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
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