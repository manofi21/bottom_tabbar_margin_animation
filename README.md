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