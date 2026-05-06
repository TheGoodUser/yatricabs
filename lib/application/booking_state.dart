import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/data/models/booking_model.dart';
import 'package:yatri_cab/data/models/place_model.dart';

class BookingState extends Notifier<BookingRequest> {
  @override
  BookingRequest build() => BookingRequest();

  void updatePickup(PlaceModel place) {
    state = state.copyWith(pickupPlace: place);
  }

  void updateDestination(PlaceModel place) {
    state = state.copyWith(destinationPlace: place);
  }

  void updateDateTime(DateTime datetime) {
    state = state.copyWith(pickupDate: datetime);
  }

  void updateTimeOfDay(TimeOfDay time) {
    state = state.copyWith(pickupTime: time);
  }

  bool get isValid =>
      state.destinationPlace != null &&
      state.pickupPlace != null &&
      state.pickupDate != null &&
      state.pickupTime != null;
}
