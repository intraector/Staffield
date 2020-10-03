import 'package:Staffield/views/entries/vmodel_entries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AreaSliverAppBar extends StatelessWidget {
  AreaSliverAppBar({@required this.vModel});
  final VModelEntries vModel;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("СМЕНЫ ПЕРСОНАЛА",
            style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 0),
                  blurRadius: 8,
                ),
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 0),
                  blurRadius: 20,
                ),
              ],
            )),
        background: Image.network(
          "https://images.squarespace-cdn.com/content/5590cbb1e4b0927589e6557c/1466375978654-MLF3R0OMYXNX5BPN9LGR/image-asset.jpeg?format=1500w&content-type=image%2Fjpeg",
          fit: BoxFit.fitWidth,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => Get.find<VModelEntries>().refreshDb(),
        ),
        IconButton(
          icon: Icon(Icons.create_rounded),
          onPressed: () => vModel.generateRandomEntries(days: 720, recordsPerDay: 3),
        ),
      ],
    );
  }
}
