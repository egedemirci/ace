

import 'package:geocoding/geocoding.dart';

class GeoCity{
  GeoCity({required this.lt,required this.lg});

  double lg;
  double lt;


  Future getPlace() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lt, lg);
    return placemarks[0].administrativeArea;
  }


}