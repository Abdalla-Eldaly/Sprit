/// Phone : "01028372333"
/// Order : "اوريجنال دابل بيف"

class Data {
  Data({
      this.phone, 
      this.order,});

  Data.fromJson(dynamic json) {
    phone = json['Phone'];
    order = json['Order'];
  }
  String? phone;
  String? order;
Data copyWith({  String? phone,
  String? order,
}) => Data(  phone: phone ?? this.phone,
  order: order ?? this.order,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Phone'] = phone;
    map['Order'] = order;
    return map;
  }

}