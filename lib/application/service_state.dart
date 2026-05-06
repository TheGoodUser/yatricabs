import 'package:flutter/foundation.dart';

enum ServiceType {
  outstation("outstation_trip.svg", "Outstation Trip"),
  local("local_trip.svg", "Local Trip"),
  airport("airport_transfer.svg", "Airport Trasfer");

  final String logoSrc;
  final String label;
  const ServiceType(this.logoSrc, this.label);
}

@immutable
class ServiceState {
  final int index;
  final ServiceType type;

  const ServiceState({this.index = 0, required this.type});

  ServiceState copyWith({int? index, ServiceType? type}) {
    return ServiceState(type: type ?? this.type, index: index ?? this.index);
  }
}
