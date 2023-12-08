import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uis_task/features/home/data/models/fav_model.dart';

import '../../../core/theming/colors.dart';
import '../cubits/home_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var cubit = HomeCubit.get(context);

        if (cubit.favModel?.data != null) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoritesItem(
                  cubit.favModel!.data!.data![index], context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cubit.favModel!.data!.data!.length);
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.mainBlue,
          ));
        }
      },
    );
  }
}

Widget buildFavoritesItem(
  FavData model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120.h,
        child: Row(
          children: [
            SizedBox(
              width: 120.w,
              height: 120.h,
              child:
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(model.product!.image!),
                  width: 120.w,
                  height: 120.h,
                ),
                if (model.product!.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.red,
                    child:  Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  )
              ]),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(fontSize: 14.sp, height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        model.product!.price!.toString(),
                        maxLines: 2,
                        style:
                             TextStyle(fontSize: 12.sp, color: Colors.blue),
                      ),
                       SizedBox(
                        width: 5.w,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice!.toString(),
                          style:  TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            HomeCubit.get(context)
                                .changeFav(model.product!.id!);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            size: 24,
                            color: Colors.black87,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
