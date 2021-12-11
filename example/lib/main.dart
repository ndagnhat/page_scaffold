import 'package:flutter/material.dart';
import 'package:page_scaffold/page_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _controller;
  final List<PageScaffoldItem> pages = [
    PageScaffoldItem(
      icon: const Icon(Icons.home),
      lable: "Home",
      keepAlive: true,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
          ),
        );
      },
    ),
    PageScaffoldItem(
      icon: const Icon(Icons.calendar_today),
      lable: "Calendars",
      keepAlive: true,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Calendars"),
          ),
        );
      },
    ),
    PageScaffoldItem(
      icon: const Icon(Icons.settings),
      lable: "Settings",
      keepAlive: true,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
        );
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _changePage(int page) {
    _controller.jumpToPage(page);
  }

  Widget _buildBottomNavigationBar(BuildContext context, int index) {
    return BottomNavigationBar(
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 22,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: _changePage,
      items: pages
          .map((e) => BottomNavigationBarItem(
                icon: e.icon,
                label: e.lable,
              ))
          .toList(),
    );
  }

  Widget _buildLeftNavigationBar(BuildContext context, int selectedIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var item = pages[index];
              return ListTile(
                title: Text(item.lable),
                leading: item.icon,
                selected: selectedIndex == index,
                onTap: () {
                  _changePage(index);
                },
              );
            },
            itemCount: pages.length,
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    return pages[index].builder(context);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      controller: _controller,
      bottomNavigationBarBuilder: _buildBottomNavigationBar,
      leftNavigationBarBuilder: _buildLeftNavigationBar,
      pageBuilder: _buildPage,
      pageCount: pages.length,
    );
  }
}
