import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import './add_place_screen.dart';

//Provider
import '../providers/amazing_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<AmazingPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<AmazingPlaces>(
                    child: Center(
                      child: const Text('Got no places yet!'),
                    ),
                    builder: (ctx, amazingPlaces, ch) =>
                        amazingPlaces.items.length <= 0
                            ? ch
                            : ListView.builder(
                                itemCount: amazingPlaces.items.length,
                                itemBuilder: (ctx, i) => ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          amazingPlaces.items[i].image,
                                        ),
                                      ),
                                      title: Text(amazingPlaces.items[i].title),
                                      onTap: () {
                                        // Go to details....
                                      },
                                    )),
                  ),
      ),
    );
  }
}
