// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewExample extends StatefulWidget {
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }

// class WebViewExampleState extends State<WebViewExample> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         return showDialog(
//             context: context,
//             builder: (context) {
//               return new AlertDialog(
//                 title: const Text("Exit App"),
//                 content: const Text("Do you want to exit an App?"),
//                 actions: [
//                   new TextButton(
//                     child: const Text("No"),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   new ElevatedButton(
//                     child: const Text("Yes"),
//                     onPressed: () {
//                       SystemNavigator.pop();
//                     },
//                   ),
//                 ],
//               );
//             });
//       },
//       child: Scaffold(
//         appBar: AppBar(title: Text("Blood Donation")),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Positioned(
//                 child: Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: WebView(
//                   initialUrl: 'http://hibeeye.com',
//                   javascriptMode: JavascriptMode.unrestricted,
//                   navigationDelegate: (NavigationRequest request) {
//                     if (request.url.startsWith(
//                         'http://www.hibeeye.com/donor-registration/')) {
//                       print('blocking navigation to $request}');
//                       return NavigationDecision.navigate;
//                     }
//                     if (request.url.startsWith(
//                         'http://www.hibeeye.com/patient-registration/')) {
//                       print('blocking navigation to $request}');
//                       return NavigationDecision.prevent;
//                     }
//                     print('allowing navigation to $request');
//                     return NavigationDecision.navigate;
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
