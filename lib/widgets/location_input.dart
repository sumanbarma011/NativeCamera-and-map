import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'dart:developer';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});
  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  Location? trackedLocation;
  bool _isGettingLocation = false;
  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    log('========================');
    locationData = await location.getLocation();
    log('========================');
 print(locationData.latitude);
    print(locationData.longitude);
    setState(() {
      _isGettingLocation = false;
    });
    log('========================');

   
    var lat=locationData.latitude;
    var lng=locationData.longitude;

  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No location choosed',
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (_isGettingLocation == true) {
      content = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: content),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get Current Location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Get Current Location'))
          ],
        )
      ],
    );
  }
}
