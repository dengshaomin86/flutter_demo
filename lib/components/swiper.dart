import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配
import '../config/service.dart';

class SwiperDiy extends StatelessWidget {
  final List swiperData;

  SwiperDiy({this.swiperData});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334); // 设置设计稿尺寸
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(400),
      child: Swiper(
        itemCount: swiperData.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${serviceUrl+swiperData[index]['src']}", fit: BoxFit.cover,);
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
