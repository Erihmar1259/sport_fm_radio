import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sport_fm_radio/controller/bottom_nav_controller.dart';
import 'package:sport_fm_radio/controller/radio_controller.dart';
import 'package:sport_fm_radio/utils/color_const.dart';
import 'package:sport_fm_radio/utils/dimen_const.dart';
import 'package:sport_fm_radio/utils/img_const.dart';
import 'package:sport_fm_radio/views/screens/bottom_nav_menu.dart';
import 'package:sport_fm_radio/views/widgets/custom_text.dart';
import 'package:sport_fm_radio/views/widgets/setting_card.dart';

import '../../widgets/custom_loading.dart';

class FavPlayerScreen extends StatelessWidget {
  const FavPlayerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put(RadioController());
    return WillPopScope(
      onWillPop: () async {
        Get.snackbar("sorry".tr, "cant_use".tr, colorText: secondaryColor);
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor.withOpacity(0.8),
        appBar: AppBar(
          backgroundColor: whiteColor.withOpacity(0),
          centerTitle: true,
          title: Obx(
                () => CustomText(
              text: radioController.name.value,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              //color: whiteColor,
            ),
          ),
          leading: BackButton(
            //color: whiteColor,
            onPressed: () {
              radioController.player.stop();
              Get.back();
            },
          ),
          actions: [
            Obx(
              () => (radioController.favLists.isEmpty)
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        if (radioController.favLists.length == 1) {
                          if (radioController.favLists.contains(
                              radioController.favLists[
                                  radioController.selectedFavIndex.value])) {
                            radioController.player.stop();
                            Get.back();
                            radioController.removeFav(radioController.favLists[
                                radioController.selectedFavIndex.value]);
                          } else {
                            radioController.addToFav(radioController.favLists[
                                radioController.selectedFavIndex.value]);
                          }
                        } else if (radioController.favLists.length > 1) {
                          if (radioController.favLists.contains(
                              radioController.favLists[
                                  radioController.selectedFavIndex.value])) {
                            radioController.removeFav(radioController.favLists[
                                radioController.selectedFavIndex.value]);
                          } else {
                            radioController.addToFav(radioController.favLists[
                                radioController.selectedFavIndex.value]);
                          }
                        }
                        // radioController.addToFav(radioController.favLists[radioController.selectedFavIndex.value]);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Image.asset(
                          radioController.favLists.contains(radioController
                                  .favLists[((radioController
                                              .selectedFavIndex.value <
                                          radioController.favLists.length) ||
                                      (radioController.selectedFavIndex.value <
                                          0))
                                  ? radioController.selectedFavIndex.value
                                  : (radioController.favLists.length - 1)])
                              ? favFillImg
                              : favImg,
                          width: 20.w,
                          height: 20.h,
                          color: secondaryColor,
                        ),
                      ),
                    ),
            )
          ],
        ),
        body: Obx(
          () => (radioController.favLists.isEmpty)
              ? const SizedBox.shrink()
              : Center(
                  child: Column(
                    children: [
                      kSizedBoxH15,
                      Image.asset(
                        smallWaveImg,
                        color: whiteColor,
                        width: MediaQuery.of(context).size.width * .8,
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        height: 50.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  radioController.changeFavIndex(
                                      radioController.selectedFavIndex.value - 1);
                                  if (radioController.selectedFavIndex.value <
                                      0) {
                                    Get.snackbar("sorry".tr, "no_previous".tr,
                                        colorText: secondaryColor);
                                    radioController.firstFavChannel();
                                  } else {
                                    radioController.changeIndexPlayFavRadio(
                                        radioController.selectedFavIndex.value);
                                  }
                                },
                                child: Image.asset(
                                  backwardImg,
                                  width: 40.w,
                                  height: 40.h,
                                  color: secondaryColor,
                                )),
                            Obx(
                              () => InkWell(
                                  onTap: () {
                                    radioController.playPause();
                                  },
                                  child: (radioController.isAudioLoading.value)
                                      ? SizedBox(
                                      width: 40.w,
                                      height: 40.h,
                                      child: const CustomLoading())
                                      : Image.asset(
                                          radioController.isPause.value
                                              ? pauseImg
                                              : playImg,
                                          width: 40.w,
                                          height: 40.h,
                                          color: secondaryColor,
                                        )),
                            ),
                            InkWell(
                                onTap: () {
                                  radioController.changeFavIndex(
                                      radioController.selectedFavIndex.value + 1);
                                  if (radioController.selectedFavIndex.value >
                                      radioController.favLists.length - 1) {
                                    Get.snackbar("sorry".tr, "no_more_list".tr,
                                        colorText: secondaryColor);
                                    radioController.lastFavChannel();
                                  } else {
                                    radioController.changeIndexPlayFavRadio(
                                        radioController.selectedFavIndex.value);
                                  }
                                },
                                child: Image.asset(
                                  forwardImg,
                                  width: 40.w,
                                  height: 40.h,
                                  color: secondaryColor,
                                )),
                          ],
                        ),
                      ),
                      kSizedBoxH20,
                      Expanded(
                          child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          topLeft: Radius.circular(30.r),
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 5.w, right: 5.w, top: 20.h),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.r),
                                topLeft: Radius.circular(30.r),
                              )),
                          child: ListView.builder(
                              itemCount: radioController.favLists.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: SettingsCardWidget(
                                        cardColor: radioController
                                                    .selectedFavIndex.value ==
                                                index
                                            ? secondaryColor
                                            : whiteColor,
                                        childWidget: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  fmImg,
                                                  width: 20.w,
                                                  height: 20.h,
                                                  color: radioController
                                                              .selectedFavIndex
                                                              .value ==
                                                          index
                                                      ? whiteColor
                                                      : secondaryColor,
                                                ),
                                                kSizedBoxW10,
                                                CustomText(
                                                    text: radioController
                                                        .favLists[index]
                                                        .stationName,
                                                    fontWeight: FontWeight.bold,
                                                    color: radioController
                                                                .selectedFavIndex
                                                                .value ==
                                                            index
                                                        ? whiteColor
                                                        : blackTextColor),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  radioController
                                                      .changeFavIndex(index);
                                                  radioController.playFavRadio(
                                                      radioController
                                                          .favLists[index].url,
                                                      radioController
                                                          .favLists[index]
                                                          .stationName,
                                                      index);
                                                },
                                                child: Image.asset(
                                                  radioController
                                                              .selectedFavIndex
                                                              .value ==
                                                          index
                                                      ? smallWaveImg
                                                      : playImg,
                                                  width: radioController
                                                              .selectedFavIndex
                                                              .value ==
                                                          index
                                                      ? 50.w
                                                      : 20.w,
                                                  height: radioController
                                                              .selectedFavIndex
                                                              .value ==
                                                          index
                                                      ? 30.h
                                                      : 20.h,
                                                  color: radioController
                                                              .selectedFavIndex
                                                              .value ==
                                                          index
                                                      ? whiteColor
                                                      : secondaryColor,
                                                ))
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
