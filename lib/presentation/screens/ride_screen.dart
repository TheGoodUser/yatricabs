import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatri_cab/application/providers.dart';

class RideScreen extends ConsumerWidget {
  const RideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Ride Route")),
      body: FlutterMap(
        options: MapOptions(
          // Center the map on the start of the journey
          initialCenter: booking.polylinePoints!.isNotEmpty
              ? booking.polylinePoints!.first
              : const LatLng(20.5937, 78.9629),
          initialZoom: 14,
        ),
        children: [
          // 1. The BASE MAP (Buildings, Streets, Rivers)
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'com.example.yatri_cab', // Required by OSM terms
          ),

          // 2. The ROUTE (The polyline you already have)
          PolylineLayer(
            polylines: [
              Polyline(
                points: booking.polylinePoints!,
                color: const Color(0xFF38B000),
                strokeWidth: 5.0,
              ),
            ],
          ),

          // 3. Optional: Add Markers for Pickup and Destination
          MarkerLayer(
            markers: [
              if (booking.pickupPlace != null)
                Marker(
                  point: LatLng(
                    double.parse(booking.pickupPlace!.lat!),
                    double.parse(booking.pickupPlace!.lon!),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              if (booking.destinationPlace != null)
                Marker(
                  point: LatLng(
                    double.parse(booking.destinationPlace!.lat!),
                    double.parse(booking.destinationPlace!.lon!),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
