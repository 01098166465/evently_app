import 'package:evently/app_theme.dart';
import 'package:evently/providers/app_manager_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  static const String routeName = "location-screen";

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (location) {
                appProvider.setEventLocation(location);
                Navigator.of(context).pop();
              },
              markers: appProvider.markers,
              onMapCreated: (GoogleMapController controller) {
                appProvider.mapController = controller;
              },
              mapType: MapType.hybrid,

              initialCameraPosition: appProvider.cameraPosition,
            ),
          ),

          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(color: AppTheme.primary),
            child: Center(
              child: Text(
                "Tap on Location To Select",
                style: textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
