import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/home_cubit.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) =>ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavorites(),
              separatorBuilder: (context, index) => Divider(),
              itemCount:10    ),

    );
  }
}


Widget buildFavorites( )=> Padding(
  padding: EdgeInsets.all(20 ),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          child: Stack(
              alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage('https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg'),
              width: 120,
              height: 120,

            ),
            if (true)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
          ]),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'sss',
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (true )
                    Text(
                      '170',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                       //   HomeCubit.get(context).changeFavorites(model.product.id);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 12,color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);