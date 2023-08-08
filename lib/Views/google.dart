import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class google extends StatefulWidget {
  const google({super.key});

  @override
  State<google> createState() => _googleState();
}

class _googleState extends State<google> {
  InAppWebViewController? inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (val) {
              if ("book" == val) {
              } else if ("search" == val) {
                // return AlertDialog()
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: "book",
                  child: Row(
                    children: [
                      Icon(Icons.bookmark, color: Colors.black),
                      Text("All Bookmarks"),
                    ],
                  )),
              PopupMenuItem(
                  value: "search",
                  child: Row(
                    children: [
                      Icon(
                        Icons.screen_search_desktop_outlined,
                        color: Colors.black,
                      ),
                      Text("Search Engine"),
                    ],
                  ))
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          return (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi)
              ? InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse("https://www.google.com/"),
                  ),
                  onLoadStart: (controller, url) {
                    setState(() {
                      inAppWebViewController = controller;
                    });
                  },
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/Assets/image.jpg"),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
