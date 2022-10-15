import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String url;

  const CustomWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    print('webview ${widget.url}');
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(

        appBar: AppBar(),
        extendBodyBehindAppBar: true,

        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   shadowColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            WebView(

              initialUrl: 'https://docs.google.com/viewer?url=${widget.url}',

              onPageFinished: (value){
                setState((){
                  isLoading=false;
                });
              },

            ),
            if(isLoading)
              const CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
