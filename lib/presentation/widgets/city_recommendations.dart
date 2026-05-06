import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/fetch_state.dart';
import 'package:yatri_cab/application/providers.dart';
import 'package:yatri_cab/data/models/place_model.dart';

class CityRecommendations extends ConsumerWidget {
  final Function(PlaceModel) onCitySelected;
  const CityRecommendations({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(placeSearchProvider);
    final status = searchState.status;

    // 1. Loading State: Center it and make it clean
    if (status == FetchStatus.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            color: Color(0xFF38B000), // Match your theme color
            strokeWidth: 3,
          ),
        ),
      );
    }

    // 2. Error State: Use a friendly icon and message
    if (status == FetchStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                searchState.error ?? 'Connection Error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Idle/Success State
    final data = searchState.data ?? [];

    if (data.isEmpty) {
      // Show "Search" prompt if Idle, or "Not Found" if Success but list empty
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined, color: Colors.grey[300], size: 60),
            const SizedBox(height: 10),
            Text(
              status == FetchStatus.idle
                  ? "Search for your destination"
                  : "No locations found",
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true, // Useful if placed inside a Column
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, indent: 60),
        itemBuilder: (context, index) {
          final place = data[index];

          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFF1F1F1),
              child: Icon(
                Icons.location_on,
                color: Color(0xFF38B000),
                size: 20,
              ),
            ),
            title: Text(
              place.name ?? "Unknown Location",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            subtitle: Text(
              place.displayName ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            onTap: () => onCitySelected(place),
          );
        },
      ),
    );
  }
}
