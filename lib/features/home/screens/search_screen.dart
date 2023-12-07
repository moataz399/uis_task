import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../cubits/home_cubit.dart';
import '../cubits/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var searchController = TextEditingController();
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(children: [
                  TextFormField(
                    onFieldSubmitted: (String text) {
                      SearchCubit.get(context).search(text);
                    },
                    controller: searchController,
                    validator: (value) =>
                        value!.isEmpty ? 'please search for something' : null,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 18.h,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.mainBlue,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lighterGray,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    obscureText: false,
                    style: TextStyles.font14DarkBlueMedium,
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItems(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data!
                              .length),
                    )
                ]),
              ),
            ));
      },
    );
  }
}

Widget buildSearchItems(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child:
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
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
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        model.price.toString(),
                        maxLines: 2,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      if (HomeCubit.get(context).fav[model.id] != null)
                        CircleAvatar(
                          backgroundColor: HomeCubit.get(context).fav[model.id]!
                              ? AppColors.mainBlue
                              : Colors.grey,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                HomeCubit.get(context).changeFav(model.id);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 12,
                                color: Colors.white,
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
