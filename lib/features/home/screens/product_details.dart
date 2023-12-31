import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import 'package:uis_task/core/routing/routes.dart';
import 'package:uis_task/core/widgets/big_text.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/expandable_text.dart';
import '../cubits/home_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.pushNamed(Routes.mapScreen);
                      },
                      icon: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.mainBlue,
                      )),
                ],
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                          child: Center(
                            child: Container(
                              height: 250.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  cubit.productDetails!.data!.image!,
                                ),
                              )),
                            ),
                          ),
                        ),
                        if (cubit.productDetails!.data!.discount != 0)
                          Container(
                            height: 30,
                            width: 100,
                            padding:  EdgeInsets.symmetric(horizontal: 5.w),
                            color: Colors.red,
                            child:  Text('Discount',
                                style: TextStyle(
                                    fontSize: 20.0.sp, color: Colors.white)),
                          )
                      ],
                    ),
                    verticalSpace(15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: BigText(
                        text: cubit.productDetails!.data!.name!,
                        size: 25,
                        color: Colors.black,
                        textOverflow: TextOverflow.fade,
                      ),
                    ),
                    verticalSpace(8),
                    Row(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: BigText(
                                text: "${cubit.productDetails!.data!.price}\$",
                                size: 25,
                                color: AppColors.mainBlue,
                                textOverflow: TextOverflow.fade,
                              ),
                            ),
                            if (cubit.productDetails!.data!.discount != 0)
                              Text(
                                '${cubit.productDetails!.data!.oldPrice}',
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22.sp,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: BigText(
                        text: 'Description:',
                        size: 18.sp,
                        color: Colors.black87,
                        textOverflow: TextOverflow.fade,
                      ),
                    ),
                    verticalSpace(6),
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w),
                      child: ExpandableText(
                        text: '${cubit.productDetails!.data!.description}',
                      ),
                    ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
