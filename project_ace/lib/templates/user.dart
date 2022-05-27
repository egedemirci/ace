import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyUser {
  String name, username, email, phone, website;
  int id;
  Address address;
  Company company;

  MyUser(
      {required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website,
      required this.id,
      required this.address,
      required this.company});

  factory MyUser.fromJSON(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJSON() => _$UserToJson(this);
}

@JsonSerializable()
class Geo {
  String lat, lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJSON(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJSON() => _$GeoToJson(this);
}

@JsonSerializable()
class Address {
  String city, street, suite, zipcode;
  Geo geo;
  Address(
      {required this.city,
      required this.street,
      required this.suite,
      required this.zipcode,
      required this.geo});

  factory Address.fromJSON(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJSON() => _$AddressToJson(this);
}

@JsonSerializable()
class Company {
  String name, catchPhrase, bs;
  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJSON(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJSON() => _$CompanyToJson(this);
}
