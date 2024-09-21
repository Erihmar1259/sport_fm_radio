import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sport_fm_radio/utils/color_const.dart';
import 'package:sport_fm_radio/utils/dimen_const.dart';
import 'package:sport_fm_radio/views/widgets/setting_card.dart';

import '../../widgets/custom_card.dart';
import '../../widgets/custom_text.dart';
import 'change_language.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
            toolbarHeight: kToolbarHeight+10.h,
            backgroundColor: whiteColor,
            centerTitle: true,
            title: Image.asset("assets/images/logo.webp")
        ),
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              CustomText(text: 'general'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ChangeLanguageScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/language.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'language'.tr,fontWeight: FontWeight.bold)
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'lang'.tr,
                             color: greyColor.withOpacity(0.6),
                          ),
                          Image.asset("assets/images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              kSizedBoxH20,
              CustomText(text: 'other'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/policy.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'policy'.tr,fontWeight: FontWeight.bold,)
                        ],
                      ),
                      Image.asset("assets/images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                    ],
                  ),
                ),
              ),
              kSizedBoxH20,
              SettingsCardWidget(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/info.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(text: 'version'.tr,fontWeight: FontWeight.bold,),
                      ],
                    ),
                    const CustomText(text: '1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
