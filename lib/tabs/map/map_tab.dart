import 'package:evently/app_theme.dart';
import 'package:evently/providers/app_manager_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
    //appProvider.setLocationListener();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppTheme.primary,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            appProvider.getLocation();
          },
          child: Icon(Icons.gps_fixed, color: AppTheme.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GoogleMap(
                markers: appProvider.markers,
                onMapCreated: (GoogleMapController controller) {
                  appProvider.mapController = controller;
                },
                mapType: MapType.hybrid,

                initialCameraPosition: appProvider.cameraPosition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
