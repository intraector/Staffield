import 'package:Staffield/views/startup/vmodel_startup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStartup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: VModelStartup(),
      builder: (_) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: FlutterLogo(
              size: MediaQuery.of(context).size.width / 2,
            )),
            Container(
              alignment: Alignment.center,
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
