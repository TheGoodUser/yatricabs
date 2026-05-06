class PlaceModel {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? type;
  int? placeRank;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;

  PlaceModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
  });

  PlaceModel.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    type = json['type'];
    placeRank = json['place_rank'];
    importance = json['importance'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['licence'] = licence;
    data['osm_type'] = osmType;
    data['osm_id'] = osmId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['type'] = type;
    data['place_rank'] = placeRank;
    data['importance'] = importance;
    data['addresstype'] = addresstype;
    data['name'] = name;
    data['display_name'] = displayName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  String? cityDistrict;
  String? county;
  String? stateDistrict;
  String? state;
  String? iSO31662Lvl4;
  String? country;
  String? countryCode;

  Address({
    this.cityDistrict,
    this.county,
    this.stateDistrict,
    this.state,
    this.iSO31662Lvl4,
    this.country,
    this.countryCode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    cityDistrict = json['city_district'];
    county = json['county'];
    stateDistrict = json['state_district'];
    state = json['state'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_district'] = cityDistrict;
    data['county'] = county;
    data['state_district'] = stateDistrict;
    data['state'] = state;
    data['ISO3166-2-lvl4'] = iSO31662Lvl4;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
