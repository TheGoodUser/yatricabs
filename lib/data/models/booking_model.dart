import 'package:flutter/material.dart';
import 'package:yatri_cab/data/models/place_model.dart';

class BookingRequest {
  final PlaceModel? pickupPlace;
  final PlaceModel? destinationPlace;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;

  BookingRequest({
    this.pickupPlace,
    this.destinationPlace,
    this.pickupDate,
    this.pickupTime,
  });

  BookingRequest copyWith({
    PlaceModel? pickupPlace,
    PlaceModel? destinationPlace,
    DateTime? pickupDate,
    TimeOfDay? pickupTime,
  }) {
    return BookingRequest(
      pickupPlace: pickupPlace ?? this.pickupPlace,
      destinationPlace: destinationPlace ?? this.destinationPlace,
      pickupDate: pickupDate ?? this.pickupDate,
      pickupTime: pickupTime ?? this.pickupTime,
    );
  }
}
