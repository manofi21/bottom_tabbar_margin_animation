import 'package:flutter/material.dart';
import 'package:tabbar_margin_animation/size_utils.dart';

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
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: List.generate(
          tabController.length,
          (index) => Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 72,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 56,
          child: Stack(
            children: [
              /// For the background
              tabGradientBackground(),
              
              /// For the line indicator
              upperLineTabIndicator(),

              /// For the item tabbar
              tabItemNavigation(widget.listOfItemPage)
            ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder upperLineTabIndicator() {
    var marginValue = SizeUtils(context, tabController).marginValue;
    return AnimatedBuilder(
      animation: tabController.animation ?? tabController,
      builder: (context, child) => Positioned(
        left: SizeUtils(context, tabController).leftPosition -
            (!tabController.offset.isNegative
                ? 0
                : calculateMargin(tabController.offset, marginValue)),
        right: SizeUtils(context, tabController).rightPosition -
            (tabController.offset.isNegative
                ? 0
                : calculateMargin(tabController.offset, marginValue)),
        child: SizedBox(
          height: 6,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32), top: Radius.circular(8)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AnimatedBuilder tabGradientBackground() {
    return AnimatedBuilder(
      animation: tabController.animation ?? tabController,
      builder: (context, child) => Positioned(
        left: SizeUtils(context, tabController).leftPosition,
        child: Center(
          child: SizedBox(
            width: SizeUtils(context, tabController).tabWidth,
            height: 56,
            child: AnimatedOpacity(
              opacity: tabController.offset == 0 ? 1 : 0,
              duration: kThemeAnimationDuration,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.greenAccent.shade700.withOpacity(.4),
                      Colors.greenAccent.shade700.withOpacity(0.1),
                      Colors.greenAccent.shade700.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row tabItemNavigation(List<NavigationItemModel> pages) {
    return Row(
      children: List.generate(
        pages.length,
        (index) => SizedBox(
          height: 56,
          width: SizeUtils(context, tabController).tabWidth,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                tabController.animateTo(index);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        pages[index].icon,
                        color: tabController.index == index
                            ? Colors.green.shade900
                            : Colors.grey.shade700,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        pages[index].label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: tabController.index == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: tabController.index == index
                              ? Colors.green.shade900
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
