import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/fetch_state.dart';
import 'package:yatri_cab/application/service_state.dart';
import 'package:yatri_cab/data/models/place_model.dart';
import 'package:yatri_cab/data/services/place_search_service.dart';

class PlaceSearchNotifier extends Notifier<FetchState<List<PlaceModel>>> {
  Timer? _debounce;
  CancelToken? _cancelToken;

  @override
  FetchState<List<PlaceModel>> build() {
    ref.onDispose(() {
      _debounce?.cancel();
      _cancelToken?.cancel();
    });
    return FetchState(data: [], status: FetchStatus.idle);
  }

  Future<void> onQueryChanged({
    required String query,
    required ServiceType type,
  }) async {
    // To cancel previous debouncer when typed fast
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Cancel the old network request bfore starting new one
    _cancelToken = CancelToken();

    // short query => resetting to idle state
    if (query.trim().length < 3) {
      _cancelToken?.cancel("Query too short");
      state = state.copyWith(
        status: FetchStatus.idle,
        data: [],
        clearError: true,
      );
      return;
    }

    // Start loading
    state = state.copyWith(status: FetchStatus.loading);

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _cancelToken?.cancel("New search started");
      _cancelToken = CancelToken();

      try {
        final results = await searchPlace(
          name: query,
          type: type,
          cancelToken: _cancelToken!,
        );
        state = state.copyWith(
          status: FetchStatus.success,
          data: results,
          clearError: true,
        );
      } on DioException catch (e) {
        if (CancelToken.isCancel(e)) return;

        state = state.copyWith(
          status: FetchStatus.error,
          error: "Could not find locations. Please try again.",
        );
      } catch (e, st) {
        state = state.copyWith(
          status: FetchStatus.error,
          error: kDebugMode ? e.toString() : "Search Failed",
        );
        log("[PLACE SEARCH NOTIFIER]\n$e\n\n$st");
      }
    });
  }
}
