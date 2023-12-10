import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import 'package:uis_task/core/routing/routes.dart';
import 'package:uis_task/core/theming/colors.dart';
import 'package:uis_task/core/theming/styles.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';

import '../../../core/helpers/spacing.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {
        if (state is FavoritesSuccess) {
          if (!state.model.status!) {
            Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        if (cubit.productsModel != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: HomeCubit.get(context)
                      .productsModel!
                      .data!
                      .banners!
                      .map(
                        (e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250.h,
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    reverse: false,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: const Duration(seconds: 2),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                verticalSpace(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Products ',
                    style: TextStyles.font24BlackBold,
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.73,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                      cubit.productsModel!.data!.products!.length,
                      (index) => GestureDetector(
                            onTap: () async {
                              await cubit.getProductDetails(
                                  id: cubit.productsModel!.data!
                                      .products![index].id!);
                              context.pushNamed(Routes.productDetailsScreen);
                            },
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Image(
                                        image: NetworkImage(cubit.productsModel!
                                            .data!.products![index].image!),
                                        fit: BoxFit.cover,
                                        width: 200.w,
                                        height: 200.h,
                                      ),
                                      if (cubit.productsModel!.data!
                                              .products![index].discount !=
                                          0)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          color: Colors.red,
                                          child: const Text('Discount',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white)),
                                        )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          cubit.productsModel!.data!
                                              .products![index].name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyles.font14DarkBlueMedium,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${cubit.productsModel!.data!.products![index].price!}',
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyles.font13BlueSemiBold,
                                            ),
                                            horizontalSpace(10),
                                            if (cubit
                                                    .productsModel!
                                                    .data!
                                                    .products![index]
                                                    .discount !=
                                                0)
                                              Text(
                                                '${cubit.productsModel!.data!.products![index].oldPrice!}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            const Spacer(),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                cubit.changeFav(cubit
                                                    .productsModel!
                                                    .data!
                                                    .products![index]
                                                    .id!);
                                              },
                                              icon: cubit.fav[cubit
                                                          .productsModel!
                                                          .data!
                                                          .products![index]
                                                          .id]!
                                                  ?   Icon(
                                                Icons.favorite,
                                                size: 18,
                                              )
                                                  :Icon(
                                                Icons
                                                    .favorite_outline_sharp,
                                                size: 18,
                                              ) ,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                )
              ],
            ),
          );
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
