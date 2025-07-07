import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/app/app_color.dart';
import 'package:ecommerceapp/app/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_corouseal_slider.dart';
import '../widgets/product_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final TextEditingController _searchTEController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ProductSearchBar(searchController: _searchTEController,),
              SizedBox(height: 16,),
              HomeCarouselSlider()
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
}




