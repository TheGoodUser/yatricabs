import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/service_state.dart';

class ServicePageViewNotifier extends Notifier<ServiceState> {
  late PageController pageController;

  @override
  ServiceState build() {
    pageController = PageController();
    ref.onDispose(() => pageController.dispose());
    return const ServiceState(type: ServiceType.outstation, index: 0);
  }

  void onPageChanged(int newIndex) {
    // 1. Update the state
    state = state.copyWith(index: newIndex, type: ServiceType.values[newIndex]);
    // 2. Move the controller
    pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
