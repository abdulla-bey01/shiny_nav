import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int stackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('O la la'),
      ),
      body: IndexedStack(
        index: stackIndex,
        children: const [
          Center(child: Text('1', style: TextStyle(color: Colors.white))),
          Center(child: Text('2', style: TextStyle(color: Colors.white))),
          Center(child: Text('3', style: TextStyle(color: Colors.white))),
          Center(child: Text('4', style: TextStyle(color: Colors.white))),
        ],
      ),
      bottomNavigationBar: NavBar(
        shadowColor: Colors.teal,
        background: const Color.fromRGBO(24, 24, 24, 1),
        iconColor: Colors.white,
        items: [
          BarItem(id: 0, icon: Icons.home, selected: true),
          BarItem(id: 1, icon: Icons.search),
          BarItem(id: 2, icon: Icons.notifications),
          BarItem(id: 3, icon: Icons.person),
        ],
        onTapItem: (BarItem selectedItem) {
          setState(() {
            stackIndex = selectedItem.id;
          });
        },
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.shadowColor,
    required this.background,
    required this.items,
    required this.iconColor,
    required this.onTapItem,
  });
  final Color shadowColor;
  final Color background;
  final Color iconColor;
  final List<BarItem> items;
  final Function onTapItem;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final List<BarItem> items;
  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              offset: const Offset(0, 2.5),
              blurRadius: 8,
              spreadRadius: 0.1,
              blurStyle: BlurStyle.solid,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map(
            (item) {
              return SizedBox(
                width:
                    (MediaQuery.of(context).size.width - 16) / items.length / 2,
                height: 70,
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              shadowColor: Colors.teal,
                              child: InkWell(
                                onTap: () {
                                  for (var elem in items) {
                                    elem.selected = false;
                                  }
                                  item.selected = true;
                                  setState(() {});
                                  widget.onTapItem(item);
                                },
                                splashColor: Colors.white.withOpacity(0.05),
                                child: Icon(
                                  item.icon,
                                  color: widget.iconColor,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            AnimatedContainer(
                              height: 2.5,
                              duration: const Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: item.selected
                                        ? widget.shadowColor
                                        : Colors.transparent,
                                    offset: const Offset(0, 2.5),
                                    blurRadius: 8,
                                    spreadRadius: 0.1,
                                    blurStyle: BlurStyle.solid,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class BarItem {
  final int id;
  final IconData icon;
  late bool selected;

  BarItem({
    required this.id,
    required this.icon,
    this.selected = false,
  });
}
