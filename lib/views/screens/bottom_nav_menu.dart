import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_fm_radio/utils/enum.dart';
import 'package:sport_fm_radio/views/screens/channels/channels_screen.dart';
import 'package:sport_fm_radio/views/screens/favourite/favourite_screen.dart';
import 'package:sport_fm_radio/views/screens/search/search_screen.dart';
import 'package:sport_fm_radio/views/screens/settings/setting_screen.dart';
import 'package:sport_fm_radio/views/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/bottom_nav_controller.dart';
import '../../services/local_storage.dart';
import '../../utils/color_const.dart';
import '../../utils/global.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu({super.key});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: whiteColor,
                      backgroundColor: whiteColor,
                      content: SizedBox(
                        height: 1.sh * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height: 1.sh * 0.65,
                                  width: double.infinity,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString(
                                            Global.language == Language.zh.name
                                                ? Global.policyZh
                                                : Global.language ==
                                                        Language.vi.name
                                                    ? Global.policyVi
                                                    : Global.language ==
                                                            Language.hi.name
                                                        ? Global.policyHi
                                                        : Global.policyEn))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: secondaryColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? secondaryColor
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'agree'.tr,
                                  color: secondaryColor,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          isAccepted
                                              ? secondaryColor
                                              : greyColor)),
                              // ignore: sort_child_properties_last
                              child: CustomText(
                                text: "accept".tr,
                                color: whiteColor,
                                fontSize: 12,
                              ),
                              onPressed: isAccepted
                                  ? () async {
                                      LocalStorage.instance.write(
                                          StorageKey.first.name, 'notfirst');
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  final TextStyle unselectedLabelStyle = TextStyle(
      color: greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 10.sp);

  final TextStyle selectedLabelStyle = TextStyle(
      color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 10.sp);

  buildBottomNavigationMenu(context, bottomNavController) {
    return Obx(() => BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: bottomNavController.changeTabIndex,
          currentIndex: bottomNavController.tabIndex.value,
          backgroundColor: whiteColor,
          unselectedItemColor: Colors.black54,
          selectedItemColor: secondaryColor,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/fm.webp",width: 20.w,height: 20.h,color:bottomNavController.tabIndex.value==0?secondaryColor:greyColor),
              label: 'channels'.tr,
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/search.webp",width: 20.w,height: 20.h,color:bottomNavController.tabIndex.value==1?secondaryColor:greyColor),
              label: 'search'.tr,
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/favourite.webp",width: 20.w,height: 20.h,color:bottomNavController.tabIndex.value==2?secondaryColor:greyColor),
              label: 'favourite'.tr,
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/settings.webp",width: 20.w,height: 20.h,color:bottomNavController.tabIndex.value==3?secondaryColor:greyColor),
              label: 'settings'.tr,
              backgroundColor: primaryColor,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController(), permanent: false);
    return WillPopScope(
      onWillPop: ()async{
        Get.defaultDialog(
            barrierDismissible: false,
            contentPadding: EdgeInsets.all(20.w),
            backgroundColor: whiteColor.withOpacity(0.8),
            title: "exit".tr,
            titleStyle: TextStyle(color: whiteColor, fontSize: 20.sp),
            middleText: "are_u_sure".tr,

            middleTextStyle: TextStyle(color: whiteColor, fontSize: 16.sp),


            cancel: TextButton(
                onPressed: () {
                  Get.back();
                },
                child:Container(
                  width: 80.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(50.r)
                  ),
                  child: Center(child: CustomText(text: "cancel".tr,)),
                )),
          confirm: TextButton(
              onPressed: () {
                exit(0);
              },
              child:Container(
                width: 80.w,
height: 30.h,
                decoration: BoxDecoration(
                    color: secondaryColor,
                  borderRadius: BorderRadius.circular(50.r)
                ),
                child: Center(child: CustomText(text: "confirm".tr,color: whiteColor)),
              )),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        bottomNavigationBar:
            buildBottomNavigationMenu(context, bottomNavController),
        body: Obx(() => IndexedStack(
              index: bottomNavController.tabIndex.value,
              children: const [
                ChannelsScreen(),
                SearchScreen(),
                FavouriteScreen(),
                SettingScreen(),
              ],
            )),
      ),
    );
  }
}
