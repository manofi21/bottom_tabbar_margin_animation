# tabbar_margin_animation

A new Flutter project.

## Getting Started
1. Adding parameter TabController.
```dart
  late TabController tabController = TabController(
    length: pages.length,
    vsync: this,
    animationDuration: kThemeAnimationDuration,
  );
```

2. Adding variable currentIndex, and tabListener's function. After that listen the function in tabController in initState using `addListener`.
```dart
int currentIndex = 0;

  @override
  void initState() {
    tabController.addListener(tabListener);
    super.initState();
  }

/// This function just for check if the tab been changed or updated. 
/// Update the `currentIndex` variable if that happen.
void tabListener() {
    if (!tabController.indexIsChanging &&
tabController.previousIndex != tabController.index) {
        currentIndex = tabController.index;
        setState(() {});
    }
}
```

3. Implementing controller in TabBarView
```dart
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
    );
```

4. Adding bottomNavigationBar under scafold's body, and place BottomAppBar in parameter.
```dart
body:..
bottomNavigationBar: BottomAppBar(
    child: SizedBox(
        height: 56,
        child: Stack(
            children: [],
        ),
    ),
),
```

5. Adding size_utlis.dart [size_utils.dart](lib\size_utils.dart)

6. Create gradient backgroudn for bottam tabbar. Don't forget to put in children's stack list.
```dart
    ...
    child: Stack(
        children: [
            // For Background's gradient
            buildBackgroundGradasi()
        ],
    ),
    ...

  AnimatedBuilder buildBackgroundGradasi() {
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
```

7. Adding new function in size_utils.dart for determinte margin's line indicator tab
```dart
  double calculateMargin(double value, double desired) {
    value = value.abs();
    return value <= 0.5 ? (value * 2 * desired) : ((1 - value) * 2 * desired);
  }
```

7. Create Widget for line indicator tab.
```dart
  AnimatedBuilder buildIndikatorAtas() {
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
```