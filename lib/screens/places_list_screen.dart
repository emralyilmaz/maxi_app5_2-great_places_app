import 'package:flutter/material.dart';
import 'package:maxi_app5_2_great_places_app/providers/great_places.dart';
import 'package:maxi_app5_2_great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        // futurebuilder ile veriler yuklenirken CircularProgressIndicator gösterilmesi saglandı.
        future:
            Provider.of<GreatPlaces>(context, listen: false).fechAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text("Got no places yet, start adding some!"),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          onTap: () {
                            // go to detail page
                          },
                        ),
                        itemCount: greatPlaces.items.length,
                      )),
      ),
    );
  }
}
