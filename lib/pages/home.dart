import 'package:flutter/material.dart';
import '../api/home.dart';
import '../components/swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '输入内容：';

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("首页"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                FutureBuilder(
                  future: getHomePageContent("test"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var slides = snapshot.data['slides'];
                      print("slides==============>${slides}");
                      List<Map> swiper = (slides as List).cast();
                      print("swiper==============>${swiper}");
                      return Column(
                        children: [
                          SwiperDiy(swiperData:swiper)
                        ],
                      );
                    } else {
                      print('none data');
                      return Center(
                        child: Text('加载中...'),
                      );
                    }
                  },
                ),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: "类型",
                      helperText: "请输入"),
                  autofocus: false, // 关掉自动对焦
                ),
                RaisedButton(
                  onPressed: _getAction,
                  child: Text("get"),
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Container(
                  width: 200,
                  height: 1200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.red, Colors.blue])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getAction() {
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("不能为空")));
    } else {
      getHomePageContent(typeController.text.toString()).then((value) {
        setState(() {
          print(value);
          showText = value["list"][0];
        });
      });
    }
  }
}
