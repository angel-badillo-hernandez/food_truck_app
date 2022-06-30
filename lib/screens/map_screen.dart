import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:food_truck/components/sound_effects.dart' as sounds;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_truck/screens/welcome_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_truck/src/locations.dart' as locations;
import 'package:url_launcher/url_launcher_string.dart';

/// Stores the current logged-in user's account info.
late User loggedInUser;

/// A route in the FoodTruck app. This screen displays an app bar with a home
/// button that signs the user out and redirects the user to the welcome screen,
/// and a logout button which logs the user out, but only redirects to the
/// previous screen (i.e login or registration screen). The main content of
/// this screen is the Google Map styled with a dark theme, which also has
/// a reasonable amount of map markers that are meant to represent food truck
/// locations. On pressing a map marker's info window, a dialog window will
/// popup providing information about the food truck, as well as handy buttons
/// that allow the user to quickly make use of the info.
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String id = 'map_screen';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _auth = FirebaseAuth.instance;
  late String mapStyle;
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // Get the map style for the map from the json file, then set the style.
    mapStyle = await rootBundle.loadString('assets/map_style.json');
    controller.setMapStyle(mapStyle);

    // Get the food truck information, either comes from Firebase
    // Realtime Database, or the locations.json asset file in case the
    // get request fails for whatever reason.
    final foodTrucks = await locations.getFoodTrucks();

    // Create the custom icon for the map markers using an asset image.
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'images/marker.png',
      mipmaps: false,
    );
    setState(() {
      _markers.clear();
      for (final truck in foodTrucks.trucks) {
        final marker = Marker(
          icon: customIcon,
          markerId: MarkerId(truck.name),
          position: LatLng(truck.lat, truck.lng),
          infoWindow: InfoWindow(
            title: truck.name,
            snippet: '${truck.city}, ${truck.state}',
            onTap: () async {
              sounds.playDialog();
              await showInfoDialog(truck);
            },
          ),
        );
        _markers[truck.name] = marker;
      }
    });
  }

  // This displays a dialog popup containing a brief description of
  // the food truck as well as what category it falls under.
  showTruckDescription(locations.Truck truck) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            scrollable: true,
            title: ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.grey,
                onPressed: () {
                  sounds.playClick();
                  Navigator.of(context).pop();
                },
              ),
            ),
            content: Text(
                'Category: ${truck.type}\n\nDescription: ${truck.description}'),
          );
        });
  }

  // This displays a dialog popup containing a brief overview of the truck's
  // information (i.e location & directions, contact info, and image).
  showInfoDialog(locations.Truck truck) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.topCenter,
            backgroundColor: Colors.white,
            scrollable: true,
            title: Column(
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                    onPressed: () {
                      sounds.playClick();
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    truck.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'FugazOne',
                      fontSize: 30.0,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
              ],
            ),
            content: Column(
              children: [
                ListTile(
                  iconColor: Colors.grey,
                  onTap: () {
                    sounds.playDialog();
                    showTruckDescription(truck);
                  },
                  leading: const Icon(Icons.info),
                  title: Text('Category: ${truck.type}\n\nDescription: •••'),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                Image.network(truck.image),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                ListTile(
                  onTap: () async {
                    sounds.playClick();
                    await launchUrlString(
                        'https://goo.gl/maps/YLtqQjWUTmCX7YqF6',
                        mode: LaunchMode.externalApplication);
                  },
                  leading: const Icon(Icons.place),
                  iconColor: Colors.red,
                  title: Text('${truck.city}, ${truck.state}'),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                ListTile(
                  onTap: () async {
                    sounds.playClick();
                    launchUrlString(
                        'https://www.google.com/maps/place/${truck.lat}°+${truck.lng}°/@${truck.lat},${truck.lng},10z',
                        mode: LaunchMode.externalApplication);
                  },
                  leading: const Icon(Icons.directions),
                  iconColor: Colors.blue,
                  title: Text('Directions to ${truck.name}'),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                ListTile(
                  onTap: () async {
                    sounds.playClick();
                    await launchUrlString('tel:${truck.phone}');
                  },
                  leading: const Icon(Icons.phone),
                  iconColor: Colors.green,
                  title: Text(truck.phone),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                ListTile(
                  onTap: () async {
                    sounds.playClick();
                    await launchUrlString('mailto:${truck.email}');
                  },
                  leading: const Icon(Icons.email),
                  iconColor: Colors.red,
                  title: Text(truck.email),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16.0,
                ),
                ListTile(
                  onTap: () async {
                    sounds.playClick();
                    await launchUrlString(truck.url,
                        mode: LaunchMode.externalApplication);
                  },
                  leading: const Icon(Icons.public),
                  iconColor: Colors.blue,
                  title: Text(truck.url),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // Get the current user's info.
    loggedInUser = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            sounds.playClick();
            _auth.signOut();
            Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                sounds.playClick();
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Center(
          child: Text(
            'Food Truck Locations',
            style: TextStyle(
              fontFamily: 'FugazOne',
            ),
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GoogleMap(
          mapType: MapType.normal,
          buildingsEnabled: true,
          trafficEnabled: true,
          indoorViewEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(33.90976, -98.500854),
            zoom: 10,
          ),
          markers: _markers.values.toSet()),
    );
  }
}
