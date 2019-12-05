// import 'package:flutter/material.dart';
// import 'package:platform_maps_flutter/platform_maps_flutter.dart';

// class TrueMapView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PlatformMap(
//         initialCameraPosition: CameraPosition(
//           target: const LatLng(47.6, 8.8796),
//           zoom: 16.0,
//         ),
//         markers: Set<Marker>.of(
//           [
//             Marker(
//               markerId: MarkerId('AIzaSyDeKVY6XnuyrxmfmU4fRJ5gqrL56yMHNEc'),
//               position: LatLng(47.6, 8.8796),
//               consumeTapEvents: true,
//               infoWindow: InfoWindow(
//                 title: 'PlatformMarker',
//                 snippet: "Hi I'm a Platform Marker",
//               ),
//               onTap: () {
//                 print("Marker tapped");
//               },
//             ),
//           ],
//         ),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         onTap: (location) => print('onTap: $location'),
//         onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
//         compassEnabled: true,
//         onMapCreated: (controller) {
//           Future.delayed(Duration(seconds: 2)).then(
//             (_) {
//               controller.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   const CameraPosition(
//                     bearing: 270.0,
//                     target: LatLng(51.5160895, -0.1294527),
//                     tilt: 30.0,
//                     zoom: 18,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
