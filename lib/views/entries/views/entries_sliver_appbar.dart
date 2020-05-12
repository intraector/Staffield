import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesSliverAppBar extends StatelessWidget {
  EntriesSliverAppBar({@required this.vModel});
  final ScreenEntriesVModel vModel;
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
        Consumer<ScreenEntriesVModel>(
          builder: (_, vModel, __) => IconButton(
            icon: Icon(Icons.data_usage),
            onPressed: () => vModel.refreshDb(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () => vModel.generateRandomEntries(days: 180, recordsPerDay: 3),
        ),
      ],
    );
  }
}
