import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import '../util/OrientationHelper.dart';

import './route/DashboardPage.dart';
import './route/ProfilePage.dart';
import './route/SettingPage.dart';
import './route/CalendarPage.dart';
import './route/NotificationPage.dart';
import './route/OrganizationPage.dart';
import './route/ContactPage.dart';
import './route/SubAppPage.dart';
import './route/EventListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String APP_TITLE = "PlanAt Client";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: APP_TITLE),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // Since everything is a widget so the title can even be an image
        // title: Image.asset('assets/image/Icon-192.png'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  // page controller to manage a PageView
                  controller: page,
                  // will shows on top of all items, it can be a logo or a Title text
                  // title: Image.asset('assets/image/Icon-192.png'),
                  // will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                  footer: const Text('Version: Dev'),
                  // List of SideMenuItem to show them on SideMenu
                  items: <SideMenuItem>[
                    SideMenuItem(
                      // Priority of item to show on SideMenu, lower value is displayed at the top
                      priority: 0,
                      title: 'Dashboard',
                      onTap: () => page.jumpToPage(0),
                      icon: const Icon(Icons.home_rounded),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Notification',
                      onTap: () => page.jumpToPage(1),
                      icon: const Icon(Icons.circle_notifications_rounded),
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SideMenuItem(
                      priority: 2,
                      title: 'Event List',
                      onTap: () => page.jumpToPage(2),
                      icon: const Icon(Icons.format_list_bulleted_rounded),
                    ),
                    SideMenuItem(
                      priority: 3,
                      title: 'Calendar',
                      onTap: () => page.jumpToPage(3),
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                    SideMenuItem(
                      priority: 4,
                      title: 'Contact',
                      onTap: () => page.jumpToPage(4),
                      icon: const Icon(Icons.contact_page_rounded),
                    ),
                    SideMenuItem(
                      priority: 5,
                      title: 'Organization',
                      onTap: () => page.jumpToPage(5),
                      icon: const Icon(Icons.groups_rounded),
                    ),
                    SideMenuItem(
                      priority: 6,
                      title: 'Profile',
                      onTap: () => page.jumpToPage(6),
                      icon: const Icon(Icons.account_circle_rounded),
                    ),
                    SideMenuItem(
                      priority: 7,
                      title: 'SubApp',
                      onTap: () => page.jumpToPage(7),
                      icon: const Icon(Icons.apps_rounded),
                    ),
                    SideMenuItem(
                      priority: 8,
                      title: 'Setting',
                      onTap: () => page.jumpToPage(8),
                      icon: const Icon(Icons.settings_rounded),
                    ),
                    SideMenuItem(
                      priority: 9,
                      title: 'Exit',
                      onTap: () {},
                      icon: const Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: page,
                    children: const [
                      MyDashboardPage(),
                      MyNotificationPage(),
                      MyEventListPage(),
                      MyCalendarPage(),
                      MyContactPage(),
                      MyOrganizationPage(),
                      MyProfilePage(),
                      MySubAppPage(),
                      MySettingPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Mini Tool'),
            ),
            ListTile(
              title: const Text('Landscape Mode'),
              onTap: () {
                setLandscapeOrientation();
              },
            ),
            ListTile(
              title: const Text('Portrait Mode'),
              onTap: () {
                setPortraitOrientation();
              },
            ),
          ],
        ),
      ),
    );
  }
}
