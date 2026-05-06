import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatri_cab/data/models/booking_model.dart';
import 'package:yatri_cab/data/models/place_model.dart';
import 'package:yatri_cab/data/services/routing_service.dart';

class BookingNotifier extends Notifier<BookingRequest> {
  @override
  BookingRequest build() => BookingRequest();

  void updatePickup(PlaceModel place) async {
    state = state.copyWith(pickupPlace: place);
    await _updateRoute();
  }

  void updateDestination(PlaceModel place) async {
    state = state.copyWith(destinationPlace: place);
    await _updateRoute();
  }

  void updateDateTime(DateTime datetime) {
    state = state.copyWith(pickupDate: datetime);
  }

  void updateTimeOfDay(TimeOfDay time) {
    state = state.copyWith(pickupTime: time);
  }

  Future<void> _updateRoute() async {
    // Skip updating routing if input is left
    if (state.pickupPlace == null || state.destinationPlace == null) return;

    final start = LatLng(
      double.parse(state.pickupPlace!.lat!),
      double.parse(state.pickupPlace!.lon!),
    );

    final end = LatLng(
      double.parse(state.destinationPlace!.lat!),
      double.parse(state.destinationPlace!.lon!),
    );

    try {
      final points = await RoutingService().getRoutePolyline(start, end);
      state = state.copyWith(polylinePoints: points);
    } catch (e, st) {
      log('[BOOKING STATE]: $e\n$st');
    }
  }

  bool get isValid =>
      state.destinationPlace != null &&
      state.pickupPlace != null &&
      state.pickupDate != null &&
      state.pickupTime != null;
}
