import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.searchScreen);
                  },
                  icon: const Icon(Icons.search))
            ],
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.mainBlue,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 15,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
          ),
        );
      },
    );
  }
}
