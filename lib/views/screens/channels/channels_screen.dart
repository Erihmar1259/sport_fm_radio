import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sport_fm_radio/controller/radio_controller.dart';
import 'package:sport_fm_radio/utils/color_const.dart';
import 'package:sport_fm_radio/utils/img_const.dart';
import 'package:sport_fm_radio/views/widgets/custom_circular_loading.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/favourite_card.dart';
import '../player/original_player.dart';

class ChannelsScreen extends StatelessWidget {
  const ChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put(RadioController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          toolbarHeight: kToolbarHeight + 10.h,
          backgroundColor: whiteColor,
          centerTitle: true,
          title: Image.asset("assets/images/logo.webp")),
      body:  Obx(()=>
      (radioController.isLoading.value)?
          const Center(child: CustomCircleLoading()):
      ((radioController.stationLists).isEmpty)
          ? CustomText(text: "no_data".tr,color: secondaryColor,fontSize: 16.sp,fontWeight: FontWeight.bold,)
          : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 10.w,
                  // mainAxisSpacing: 10.w
                ),
                itemCount: radioController.stationLists.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => FmCardWidget(
                        favImg: radioController.favLists.any((element) =>
                                element.stationName ==
                                radioController.stationLists[index].stationName)
                            ? favFillImg
                            : favImg,
                        onTapFav: () {
                          if(radioController.favLists.contains(radioController.stationLists[index])){
                            radioController.removeFav(radioController.stationLists[index]);
                          }
                          else{
                            radioController.addToFav(radioController.stationLists[index]);
                          }
                        },
                        onTap: () {
                          radioController.playRadio(
                              radioController.stationLists[index].url,
                              radioController.stationLists[index].stationName,
                              index);
                          Get.to(const AudioPlayerScreen());
                          debugPrint("You tap this index $index");
                        },
                        label: radioController.stationLists[index].stationName),
                  );
                }),
          ),
    );
  }
}
