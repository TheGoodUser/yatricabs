import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/fetch_state.dart';
import 'package:yatri_cab/application/place_search_notifier.dart';
import 'package:yatri_cab/application/service_page_view_notifier.dart';
import 'package:yatri_cab/application/service_state.dart';
import 'package:yatri_cab/data/models/place_model.dart';

final servicePageViewProvider =
    NotifierProvider<ServicePageViewNotifier, ServiceState>(() {
      return ServicePageViewNotifier();
    });

final placeSearchProvider =
    NotifierProvider<PlaceSearchNotifier, FetchState<List<PlaceModel>>>(() {
      return PlaceSearchNotifier();
    });
