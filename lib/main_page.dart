import 'package:flutter/material.dart';

import 'navigator_item_model.dart';

class MainPage extends StatefulWidget {
  final List<NavigationItemModel> listOfItemPage;
  const MainPage({
    super.key,
    required this.listOfItemPage,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int currentIndex = 0;

  late TabController tabController = TabController(
    length: widget.listOfItemPage.length,
    vsync: this,
    animationDuration: kThemeAnimationDuration,
  );

  @override
  void initState() {
    tabController.addListener(tabListener);
    super.initState();
  }

  void tabListener() {
    if (!tabController.indexIsChanging &&
        tabController.previousIndex != tabController.index) {
      currentIndex = tabController.index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
