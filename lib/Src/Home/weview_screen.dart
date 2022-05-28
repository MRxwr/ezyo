import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class WebViewScreen extends StatefulWidget {
  String url;
  String title;
   WebViewScreen({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    InAppWebViewController webView;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: customAppBar(
          context: context, isLeading: true, appBarTitle: widget.title),
        body: Container(
          child:     Stack(
            children: <Widget>[
              InAppWebView(


                initialUrlRequest:
                URLRequest(url: Uri.parse(widget.url)),


                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(


                    preferredContentMode: UserPreferredContentMode.MOBILE,

                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;

                },


                onLoadStart: (InAppWebViewController controller, Uri url) {
                  print("initial Request ---> ${url}");

                },
                onLoadStop: (InAppWebViewController controller, Uri url) async {
                  String mUrl = url.toString();
                  print(url);





                },
              ),

            ],
          ) ,
        ),
      ),
    );
  }
}
