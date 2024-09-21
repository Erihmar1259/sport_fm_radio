import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sport_fm_radio/controller/bottom_nav_controller.dart';
import 'package:sport_fm_radio/controller/radio_controller.dart';
import 'package:sport_fm_radio/utils/color_const.dart';
import 'package:sport_fm_radio/utils/img_const.dart';
import 'package:sport_fm_radio/views/screens/player/search_player.dart';
import 'package:sport_fm_radio/views/widgets/custom_circular_loading.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/favourite_card.dart';
import '../player/original_player.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put(RadioController());
   // final navController = Get.put(BottomNavController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
//           leading: BackButton(
//             onPressed: (){
// navController.tabIndex.value=0;
//
//
//             },
//           ),
          toolbarHeight: kToolbarHeight+10.h,
          backgroundColor: whiteColor,
          centerTitle: true,
          title: Image.asset("assets/images/logo.webp")
      ),
      body: Column(
        children: [
          Obx(()=>
            Padding(
              padding:  EdgeInsets.all(8.w),
              child: TextFormField(
                controller: radioController.searchController.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 1.w
                    ),
                    borderRadius: BorderRadius.circular(30.r)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.w
                      ),
                      borderRadius: BorderRadius.circular(30.r)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.w
                      ),
                      borderRadius: BorderRadius.circular(30.r)
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.w
                      ),
                      borderRadius: BorderRadius.circular(30.r)
                  ),
                  // suffixIcon: InkWell(
                  //   onTap: (){
                  //     //radioController.searchChannel(radioController.searchController.value.toString());
                  //   },
                  //   child: Container(
                  //     width: 70,
                  //     height: 30,
                  //     margin: EdgeInsets.only(right: 10.w),
                  //     decoration: BoxDecoration(
                  //       color: secondaryColor,
                  //       borderRadius: BorderRadius.circular(30.r)
                  //     ),
                  //     child: Center(child: CustomText(text: "search".tr,color: whiteColor,)),
                  //   ),
                  // ),
                  prefixIcon: Padding(
                    padding:  EdgeInsets.all(10.w),
                    child: Image.asset(searchImg,color: secondaryColor,width: 10.w,height: 10.h,),
                  )
                ),
                onChanged: (value){
                  if(value.isEmpty){
                    radioController.clearSearchList();
                    Get.snackbar("sorry".tr, "please_enter_text".tr,colorText: secondaryColor);
                  }
                  else {
                    radioController.searchChannel(value);
                  }
                },
              ),
            ),
          ),
          Obx(()=>
             Expanded(child:
                 (radioController.isLoading.value)?
                    const CustomCircleLoading():
                 (radioController.searchLists.isEmpty)
                ? Center(child: CustomText(text: "no_search_data".tr,color: secondaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp,))
                : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 10.w,
                  // mainAxisSpacing: 10.w
                ),
                itemCount: radioController.searchLists.length,
                itemBuilder: (context, index) {
                  return Obx(
                        () => FmCardWidget(
                        favImg: radioController.favLists.any((element) =>
                        element.stationName ==
                            radioController.searchLists[index].stationName)
                            ? favFillImg
                            : favImg,
                        onTapFav: () {
                          if(radioController.favLists.contains(radioController.searchLists[index])){
                            radioController.removeFav(radioController.searchLists[index]);
                          }
                          else{
                            radioController.addToFav(radioController.searchLists[index]);
                          }
                          // radioController.addToFav(radioController.searchLists[index]);
                        },
                        onTap: () {
                          radioController.playSearchRadio(
                              radioController.searchLists[index].url,
                              radioController.searchLists[index].stationName,
                              index);
                          Get.to(const SearchPlayerScreen());
                          debugPrint("You tap this index $index");
                        },
                        label: radioController.searchLists[index].stationName),
                  );
                }),),
          )
        ],
      ),
    );
  }
}
