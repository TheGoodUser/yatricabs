import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/booking_state.dart';
import 'package:yatri_cab/application/fetch_state.dart';
import 'package:yatri_cab/application/place_search_notifier.dart';
import 'package:yatri_cab/application/service_page_view_notifier.dart';
import 'package:yatri_cab/application/service_state.dart';
import 'package:yatri_cab/data/models/booking_model.dart';
import 'package:yatri_cab/data/models/place_model.dart';

final servicePageViewProvider =
    NotifierProvider<ServicePageViewNotifier, ServiceState>(() {
      return ServicePageViewNotifier();
    });

// Location Textform field name management
final placeSearchProvider =
    NotifierProvider<PlaceSearchNotifier, FetchState<List<PlaceModel>>>(() {
      return PlaceSearchNotifier();
    });

// Booking related state management
final bookingProvider = NotifierProvider<BookingState, BookingRequest>(() {
  return BookingState();
});
