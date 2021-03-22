import 'package:osm_nominatim/osm_nominatim.dart';

Future<Place> searchAddress(String address) async {
  final places =
      await Nominatim.searchByName(query: address).catchError((e) => null);

  if (places == null || places.isEmpty) return null;

  return places[0];
}
