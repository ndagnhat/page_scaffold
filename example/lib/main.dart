import 'package:adaptive_scaffold/adaptive_scaffold.dart';
import 'package:flutter/material.dart';

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
  List<PageScaffoldItem> pages = [
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
  Widget build(BuildContext context) {
    return PageScaffold(
      bottomNavigationBarBuilder: (context, index) {
        return BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          items: pages
              .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    label: e.lable,
                  ))
              .toList(),
        );
      },
      leftNavigationBarBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                var item = pages[index];
                return ListTile(
                  title: Text(item.lable),
                  leading: item.icon,
                );
              },
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
          ],
        );
      },
      pageBuilder: (context, index) {
        return pages[index].builder(context);
      },
      pageCount: pages.length,
    );
  }
}
