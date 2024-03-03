/// id : 1
/// name : "test1"
/// email : "test1@mail.com"
/// phone : "01230120215"
/// university : "benha"
/// collage : "engineering"
/// academic_year : "2"
/// national_id : "123456789"
/// time : "2024-02-19 19:35:51"
/// checked : "yes"

class Person {
  Person({
      this.id, 
      this.name, 
      this.email, 
      this.phone,
    this.ticket,
      this.university, 
      this.collage, 
      this.academicYear, 
      this.nationalId, 
      this.time, 
      this.checked,});

  Person.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ticket= json['ticket'];
    phone = json['phone'];
    university = json['university'];
    collage = json['collage'];
    academicYear = json['academic_year'];
    nationalId = json['national_id'];
    time = json['time'];
    checked = json['checked'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? university;
  String? ticket;
  String? collage;
  String? academicYear;
  String? nationalId;
  String? time;
  String? checked;
Person copyWith({  int? id,
  String? name,
  String? email,
  String? phone,
  String? university,
  String? ticket,

  String? collage,
  String? academicYear,
  String? nationalId,
  String? time,
  String? checked,
}) => Person(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  phone: phone ?? this.phone,
  university: university ?? this.university,
  ticket: ticket ?? this.ticket,
  collage: collage ?? this.collage,
  academicYear: academicYear ?? this.academicYear,
  nationalId: nationalId ?? this.nationalId,
  time: time ?? this.time,
  checked: checked ?? this.checked,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['university'] = university;
    map['ticket'] = ticket;
    map['collage'] = collage;
    map['academic_year'] = academicYear;
    map['national_id'] = nationalId;
    map['time'] = time;
    map['checked'] = checked;
    return map;
  }

}