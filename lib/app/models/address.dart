import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'address.g.dart';

@HiveType(typeId: 1)
class Address extends HiveObject {
  @HiveField(0)
  String? addressLine1;
  @HiveField(1)
  String? addressLine2;
  @HiveField(2)
  String? city;
  @HiveField(3)
  String? country;
  @HiveField(4)
  String? district;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? pincode;
  @HiveField(7)
  String? state;
  @HiveField(0)
  Address(this.addressLine1, this.addressLine2, this.city, this.country,
      this.district, this.name, this.pincode, this.state);

  Address copyWith({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? country,
    String? district,
    String? name,
    String? pincode,
    String? state,
  }) {
    return Address(
      addressLine1 ?? this.addressLine1,
      addressLine2 ?? this.addressLine2,
      city ?? this.city,
      country ?? this.country,
      district ?? this.district,
      name ?? this.name,
      pincode ?? this.pincode,
      state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'country': country,
      'district': district,
      'name': name,
      'pincode': pincode,
      'state': state,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      map['addressLine1'],
      map['addressLine2'],
      map['city'],
      map['country'],
      map['district'],
      map['name'],
      map['pincode'],
      map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, country: $country, district: $district, name: $name, pincode: $pincode, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.country == country &&
        other.district == district &&
        other.name == name &&
        other.pincode == pincode &&
        other.state == state;
  }

  @override
  int get hashCode {
    return addressLine1.hashCode ^
        addressLine2.hashCode ^
        city.hashCode ^
        country.hashCode ^
        district.hashCode ^
        name.hashCode ^
        pincode.hashCode ^
        state.hashCode;
  }
}
