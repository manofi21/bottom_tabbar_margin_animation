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