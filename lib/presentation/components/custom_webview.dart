// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class CustomWebView extends StatefulWidget {
//   final String url;
//
//   const CustomWebView({Key? key, required this.url}) : super(key: key);
//
//   @override
//   State<CustomWebView> createState() => _CustomWebViewState();
// }
//
// class _CustomWebViewState extends State<CustomWebView> {
//   bool isLoading=true;
//   String url='';
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     print('webview ${widget.url}');
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//     url='https://docs.google.com/viewer?url=${widget.url}';
//     url='https://docs.google.com/gview?embedded=true&url=${widget.url}';
//     print(url);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: true,
//       child: Scaffold(
//
//         appBar: AppBar(),
//         extendBodyBehindAppBar: true,
//
//         body:  WebView(
//
//           // initialUrl: url,
//           initialUrl: widget.url,
//           // initialUrl: 'https://docs.google.com/viewer?url=${widget.url}',
//
//           allowsInlineMediaPlayback: true,
//
//
//           onPageFinished: (value){
//             setState((){
//               isLoading=false;
//             });
//           },
//
//         ),
//         // body: Stack(
//         //   alignment: Alignment.center,
//         //   children: [
//         //     WebView(
//         //
//         //       // initialUrl: 'https://docs.google.com/viewer?url=${widget.url}',
//         //       initialUrl: url,
//         //
//         //       // initialUrl: 'https://docs.google.com/viewer?url=https://dashboard.netnnetsolutions.com/NetAPI/Contents/JobFiles/3a109f54-1967-4357-b539-5dcc57141bc9.xlsx',
//         //       onPageFinished: (value){
//         //         setState((){
//         //           isLoading=false;
//         //         });
//         //       },
//         //
//         //     ),
//         //     if(isLoading)
//         //       const CustomCircularProgressIndicator(),
//         //   ],
//         // ),
//       ),
//     );
//   }
// }
