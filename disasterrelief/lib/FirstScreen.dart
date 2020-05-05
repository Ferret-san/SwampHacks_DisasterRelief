import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart';
import 'JobsListView.dart';


void main() {
  runApp(FirstScreen());
}

class FirstScreen extends StatefulWidget{
  @override
  _FirstScreen createState() => _FirstScreen();

}

class _FirstScreen extends State<FirstScreen> {

  PageController _pageController;
  WebViewController _controller;
  final icons = [Icons.list, Icons.map, Icons.settings, Icons.person];
  final titles = ['List', 'Map', 'Settings', 'Profile'];
  int _page = 0;

  @override
  Widget build(BuildContext context) {

    final title = 'Power Together';

    @override
    void initState() {
      super.initState();
      _pageController = new PageController();
    }

    @override
    void dispose(){
      super.dispose();
      _pageController.dispose();
    }

    return MaterialApp(
        title: title,

        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: new PageView(

              children: <Widget>[
                new Container(
                    child : JobsListView()
                ),
                new Container(
                  child: WebView(
                    initialUrl: 'about:blank',
                    onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    _loadHtmlFromAssets('assets/frame.html',_controller);
                    }
                  )
                ),
                new Container(

                )
              ],
                controller: _pageController,
                onPageChanged: onPageChanged
                ),
          bottomNavigationBar:  new BottomNavigationBar(items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text("Home")
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.location_city),
                title: new Text("Map")
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.people),
                title: new Text("Profile")
            )
          ],
              onTap: navigationTapped,
              currentIndex: _page
          ),

        )
    );
  }
  Future<void> _loadHtmlFromAssets(String filename, controller) async {
    String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(fileText, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }
  void navigationTapped(int page){

    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceIn
    );
  }

  void onPageChanged(int page){
    setState((){
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }
}


abstract class ListItem {}

class HeadingText implements ListItem {
  final String heading;
  final String name;
  HeadingText(this.heading, this.name);
}

class SupplyItem implements ListItem {
  final String name;
  final String description;
  final String sender;
  final String cost;
  // Need Latitude and Longitude for location
  SupplyItem(this.name, this.description, this.sender, this.cost);
}