import 'package:flutter/material.dart';
import 'package:animated_page_transition/pages/page_animation.dart';
import 'package:animated_page_transition/pages/animated_container.dart';
import 'package:animated_page_transition/pages/fade_animation.dart';
import 'package:animated_page_transition/pages/drawer.dart';
import 'package:animated_page_transition/pages/snackbar.dart';
import 'package:animated_page_transition/pages/ui_orientation.dart';
import 'package:animated_page_transition/pages/tabs_page.dart';
import 'package:animated_page_transition/pages/simple_form.dart';
import 'package:animated_page_transition/pages/dismissable_list.dart';
import 'package:animated_page_transition/pages/images.dart';
import 'package:animated_page_transition/pages/horizontal_list.dart';
import 'package:animated_page_transition/pages/mixed_list.dart';
import 'package:animated_page_transition/pages/floating_appbar.dart';
import 'package:animated_page_transition/pages/animated_widget_transition.dart';
import 'package:animated_page_transition/pages/async_page.dart';
import 'package:animated_page_transition/pages/passing_data.dart';
import 'package:animated_page_transition/pages/http_request.dart';
import 'package:animated_page_transition/pages/backgound_parse.dart';
import 'package:animated_page_transition/pages/web_sockets.dart';
import 'package:animated_page_transition/pages/sqlite_persistence.dart';
import 'package:animated_page_transition/pages/persistent_counter.dart';
import 'package:animated_page_transition/pages/video_playback.dart';
import 'package:animated_page_transition/pages/camera_page.dart';

class Choice {
  const Choice({this.title, this.icon, this.route});
  final String title;
  final String route;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Route animation', icon: Icons.arrow_drop_up, route: "/page1"),
  const Choice(
      title: 'Container animation',
      icon: Icons.arrow_drop_up,
      route: "/container"),
  const Choice(
      title: 'Fade animation',
      icon: Icons.arrow_drop_up,
      route: "/fade"),
  const Choice(
      title: 'Drawer',
      icon: Icons.arrow_drop_up,
      route: "/drawer"),
  const Choice(
      title: 'Snackbar',
      icon: Icons.arrow_drop_up,
      route: "/snackbar"),
  const Choice(
      title: 'UI Orientation',
      icon: Icons.arrow_drop_up,
      route: "/ui_orientaton"),
  const Choice(
      title: 'Bottom tabs',
      icon: Icons.arrow_drop_up,
      route: "/bottom_tabs"),
  const Choice(
      title: 'Simple form',
      icon: Icons.arrow_drop_up,
      route: "/simple_form"),
  const Choice(
      title: 'Dismissibles',
      icon: Icons.arrow_drop_up,
      route: "/dismissible_list"),
  const Choice(
      title: 'Images',
      icon: Icons.arrow_drop_up,
      route: "/images"),
  const Choice(
      title: 'Horizontal list',
      icon: Icons.arrow_drop_up,
      route: "/horizontal_list"),
  const Choice(
      title: 'Mixed list',
      icon: Icons.arrow_drop_up,
      route: "/mixed_list"),
  const Choice(
      title: 'Floating appbar',
      icon: Icons.arrow_drop_up,
      route: "/floating_appbar"),
  const Choice(
      title: 'Animated widget transition',
      icon: Icons.arrow_drop_up,
      route: "/animated_widget_transition"),
  const Choice(
      title: 'Async transitions',
      icon: Icons.arrow_drop_up,
      route: "/async_page"),
  const Choice(
      title: 'Passing data',
      icon: Icons.arrow_drop_up,
      route: "/passing_data"),
  const Choice(
      title: 'Http request',
      icon: Icons.arrow_drop_up,
      route: "/http_request"),
  const Choice(
      title: 'Background parse',
      icon: Icons.arrow_drop_up,
      route: "/background_parse"),
  const Choice(
      title: 'Websockets',
      icon: Icons.arrow_drop_up,
      route: "/websockets"),
  const Choice(
      title: 'Sqlite Persistence',
      icon: Icons.arrow_drop_up,
      route: "/sqlite_persistence"),
  const Choice(
      title: 'Persistent counter',
      icon: Icons.arrow_drop_up,
      route: "/persistent_counter"),
  const Choice(
      title: 'Video playback',
      icon: Icons.ondemand_video,
      route: "/video_playback"),
  const Choice(
      title: 'Camera',
      icon: Icons.camera,
      route: "/camera_page")
];

main() {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(
      fontFamily: 'Midnight Drive',
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
    ),
    routes: {
      '/page1': (context) => Page1(),
      '/container': (context) => AnimatedContainerPage(),
      '/fade': (context) => FadeAnimationPage(),
      '/drawer': (context) => DrawerPage(),
      '/snackbar': (context) => SnackbarPage(),
      '/ui_orientaton': (context) => UIOrientationPage(),
      '/bottom_tabs': (context) => TabsPage(),
      '/simple_form': (context) => SimpleFormPage(),
      '/dismissible_list': (context) => DismissiblePage(),
      '/images': (context) => ImagesPage(),
      '/horizontal_list': (context) => HorizontalListPage(),
      '/mixed_list': (context) => MixedListPage(),
      '/floating_appbar': (context) => FloatingAppBarPage(),
      '/animated_widget_transition': (context) => WidgetTransitionPage(),
      '/async_page': (context) => AsyncPage(),
      '/passing_data': (context) => DataListPage(),
      '/http_request': (context) => HttpRequestPage(post: fetchPost()),
      '/background_parse': (context) => BackgoundParsePage(photos: fetchPhotos()),
      '/websockets': (context) => WebSocketsPage(),
      '/sqlite_persistence': (context) => SqlitePage(),
      '/persistent_counter': (context) => PersistenCounterPage(),
      '/video_playback': (context) => VideoPlaybackPage(),
      '/camera_page': (context) => CameraPage(),

    },
  ));
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    print(choice.title);
    setState(() {
      Navigator.pushNamed(context, choice.route, arguments: "My optional parameter");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Cookbook"),
      ),
      body: ListView.builder(
        itemCount: choices.length,
        itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(choices[i].icon),
              title: Text(choices[i].title),
              onTap: () => _select(choices[i]),
            );
        }
      )
    );
  }
}
