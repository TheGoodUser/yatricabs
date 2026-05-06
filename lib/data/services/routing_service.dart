import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class RoutingService {
  final Dio _dio = Dio();

  Future<List<LatLng>> getRoutePolyline(LatLng start, LatLng end) async {
    final String coordinates =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

    final response = await _dio.get(
      'https://router.project-osrm.org/route/v1/driving/$coordinates',
      queryParameters: {'overview': 'full', 'geometries': 'geojson'},
    );

    if (response.statusCode == 200) {
      final List coords = response.data['routes'][0]['geometry']['coordinates'];

      return coords
          .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
          .toList();
    } else {
      throw Exception(
        "Routing failed with status: ${response.statusCode}\n${response.statusMessage}",
      );
    }
  }
}
