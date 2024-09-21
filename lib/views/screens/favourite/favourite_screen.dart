import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sport_fm_radio/controller/radio_controller.dart';
import 'package:sport_fm_radio/utils/color_const.dart';
import 'package:sport_fm_radio/utils/dimen_const.dart';
import 'package:sport_fm_radio/views/screens/channels/channels_screen.dart';
import 'package:sport_fm_radio/views/screens/player/fav_player.dart';
import 'package:sport_fm_radio/views/widgets/custom_text.dart';
import 'package:sport_fm_radio/views/widgets/favourite_card.dart';

import '../../../utils/img_const.dart';
import '../player/original_player.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put( RadioController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight+10.h,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Image.asset("assets/images/logo.webp")
      ),
      body: Obx(()=>
      radioController.favLists.isEmpty?
          Center(
            child: CustomText(text: "no_fav".tr,color: secondaryColor,fontSize: 16.sp,fontWeight: FontWeight.bold,),
          ):
       GridView.builder(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //crossAxisSpacing: 10.w,
              // mainAxisSpacing: 10.w
            ),
            itemCount: radioController.favLists.length,
            itemBuilder: (context, index) {

              return Obx(()=>
                 FmCardWidget(
                    favImg:favFillImg,
                  onTapFav: (){
                    radioController.removeFav(radioController.favLists[index]);
                  },
                  onTap: (){
                    radioController.playFavRadio(radioController
                        .favLists[index].url, radioController.favLists[index].stationName,index);
                    Get.to(const FavPlayerScreen());
                    debugPrint("You tap this index $index");
                  },
                    label: radioController.favLists[index].stationName),
              );
            }),


      ),
      // floatingActionButton:  InkWell(
      //     onTap: (){
      //       Get.to(const ChannelsScreen());
      //     },
      //     child: Image.asset(addImg,width: 50.w,height: 50.h,color: secondaryColor,)),
    );
  }
}
