import 'dart:convert';
import 'package:flutter/material.dart';
import '../Controller/auth_controller.dart';
import '../screens/profile_screen_design.dart';
import '../screens/sign_in_screen.dart';
import '../utils/appColor.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
    this.onProfileUpdated,
  });

  final bool isProfileScreenOpen;
  final VoidCallback? onProfileUpdated;

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileImage;
    final String? base64Photo = AuthController.userData?.photo;
    if (base64Photo != null && base64Photo.isNotEmpty) {
      try {
        // Remove base64 header if present (like: data:image/png;base64,)
        final cleanedBase64 = base64Photo.replaceFirst(
          RegExp(r'data:image/[^;]+;base64,'),
          '',
        );
        final bytes = base64Decode(cleanedBase64);
        profileImage = MemoryImage(bytes);
      } catch (e) {
        profileImage = null;
      }
    }
    return GestureDetector(
      onTap: () async {
        if (isProfileScreenOpen) {
          return;
        }
        final bool? update = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        if (update == true && onProfileUpdated != null) {
          onProfileUpdated!();
        }
      },
      child: AppBar(
        backgroundColor: AppColor.themecolor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: profileImage,
              child: profileImage == null
                  ? const Icon(Icons.person, color: Colors.grey)
                  : null,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userData?.fullName ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthController.userData?.email ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => signInScreen()),
                  (predicate) => false,
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
