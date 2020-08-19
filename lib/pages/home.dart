import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<HomePage> {
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
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: "类型",
                      helperText: "请输入"),
                  autofocus: false, // 关掉自动对焦
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text("sure"),
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

  void _choiceAction() {
    print('开始输入');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("不能为空")));
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          print(value);
          showText = "test";
        });
      });
    }
  }

  // Future 可以使用 then 链式操作
  Future getHttp(String text) async {
    try {
      Response response;
      var data = {text: text};
      response = await Dio().get("http://127.0.0.1:3002/checkOnline",
          queryParameters: data);
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: Text("首页"),
      ),
    );
  }

  void getHttp() async {
    try {
      Response response;
      response = await Dio().get("http://139.9.50.13:3000/chat/getChatList");
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}
