import 'package:blood_donation/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(Duration(seconds: 2));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blueGrey),
              home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blueGrey),
            home: MyHomePage(),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Do you want to exit an App?"),
              actions: [
                new TextButton(
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new ElevatedButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text(
            "HIBEEYE",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Center(child: CircularProgressIndicator()),
            WebView(
              key: UniqueKey(),
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'http://hibeeye.com',
              onPageStarted: (String url) {
                print("start");
              },
              onPageFinished: (String url) {
                print("end");
              },
              onWebViewCreated: (WebViewController webViewController) {
                // _controllerCompleter.future
                //     .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
            ),
          ],
        )),
      ),
    );
  }
}
