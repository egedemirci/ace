// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$UserFromJson(Map<String, dynamic> json) => MyUser(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      id: json['id'] as int,
      address: Address.fromJSON(json['address'] as Map<String, dynamic>),
      company: Company.fromJSON(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(MyUser instance) => <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'id': instance.id,
      'address': instance.address,
      'company': instance.company,
    };

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String,
      street: json['street'] as String,
      suite: json['suite'] as String,
      zipcode: json['zipcode'] as String,
      geo: Geo.fromJSON(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'suite': instance.suite,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };
