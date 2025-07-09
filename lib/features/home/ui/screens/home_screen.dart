import 'package:ecommerceapp/app/image_path.dart';
import 'package:ecommerceapp/features/home/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/app_bar_icon_button.dart';
import '../widgets/category_item_widget.dart';
import '../widgets/home_corouseal_slider.dart';
import '../widgets/home_section_header.dart';
import '../../../common/ui/widgets/product_item_widget.dart';
import '../widgets/product_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ProductSearchBar(searchController: _searchTEController),
              SizedBox(height: 16),
              HomeCarouselSlider(),
              SizedBox(height: 8),
              HomeSectionsHeader(title: 'All Categories', onTap: () {
                Get.find<BottomNavBarController>().moveToCategory();
              }),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _getCategoryList()),
              ),
              HomeSectionsHeader(title: 'Popular', onTap: () {}),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              SizedBox(height: 8),
              HomeSectionsHeader(title: 'Special', onTap: () {}),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              SizedBox(height: 8),
              HomeSectionsHeader(title: 'New', onTap: () {}),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(ImagePath.navbarlogoImage),
      actions: [
        AppBarIconButton(icon: Icons.person_2_outlined, onTap: () {}),
        SizedBox(width: 4),
        AppBarIconButton(icon: Icons.call, onTap: () {}),
        SizedBox(width: 4),
        AppBarIconButton(icon: Icons.notifications, onTap: () {}),
        SizedBox(width: 4),
      ],
    );
  }

  List<Widget> _getCategoryList() {
    List<Widget> categoryList = [];
    for (int i = 1; i < 10; i++) {
      categoryList.add(
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CategoryItemWidget(),
        ),
      );
    }
    return categoryList;
  }
  List<Widget> _getProductList() {
    List<Widget> productList = [];
    for (int i = 1; i < 10; i++) {
      productList.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ProductItemWidget(),
        ),
      );
    }
    return productList;
  }
}


