import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // iOS 风格
import 'home.dart';
import 'category.dart';
import 'cart.dart';
import 'member.dart';

// 动态组件
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => new _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("我的")),
  ];

  final List tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}
