import 'package:yatri_cab/application/service_state.dart';
import 'package:yatri_cab/data/models/place_model.dart';
import 'package:dio/dio.dart';

Future<List<PlaceModel>> searchPlace({
  required String name,
  required ServiceType type,
  required CancelToken cancelToken,
  int limit0 = 0,
  int limit1 = 30,
}) async {
  var headers = {'User-Agent': 'MyCabApp/1.0 (contact@myemail.com)'};
  var dio = Dio();
  var response = await dio.get(
    'https://nominatim.openstreetmap.org/search',
    queryParameters: {
      'q': name,
      'format': 'json',
      'addressdetails': limit0 + 1,
      'limit': limit1,
      'featuretype': 'city',

      /// DEBUG: Debug it afterwards
      'countrycodes': 'in',
    },
    cancelToken: cancelToken,
    options: Options(headers: headers),
  );

  if (response.statusCode == 200) {
    final data = (response.data as List<dynamic>).cast<Map<String, dynamic>>();
    if (data.isEmpty) throw Exception("No results");
    return data.map((city) => PlaceModel.fromJson(city)).toList();
  } else {
    throw Exception("Caught an error: ${response.statusMessage}");
  }
}
