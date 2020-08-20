import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'toast.dart';
import '../api/home.dart';

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
                RaisedButton(
                  onPressed: _postAction,
                  child: Text("post"),
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
    ToastCustomer.show("test");

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

  void _postAction() {
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("不能为空")));
    } else {
      postHttp(typeController.text.toString()).then((value) {
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
      var data = {"text": text};
      response = await Dio().get("http://192.168.5.122:3002/flutter/getList",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  Future postHttp(String text) async {
    try {
      Response response;
      var data = {"text": text};
      response = await Dio().post("http://192.168.5.122:3002/flutter/postList",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("SimpleDialog"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption One"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption One");
                },
              ),
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption Two"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption Two");
                },
              ),
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption Three"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption Three");
                },
              ),
            ],
          );
        });
  }
}
