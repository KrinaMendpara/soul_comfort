

class Users {
  Users({
    this.id,
    this.image,
    this.name,
    this.email,
    this.address,
    this.age,
    this.birthDate,
    this.phoneNumber,
    this.relation,
  });

  String? id;
  String? image;
  String? name;
  String? address;
  String? email;
  String? relation;
  String? phoneNumber;
  String? age;
  String? birthDate;


  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id : json['id'].toString(),
        image: json['image'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
        address: json['address'].toString(),
        age: json['age'].toString(),
        birthDate: json['birthDate'].toString(),
        phoneNumber: json['phoneNumber'] == null ? null : json['phoneNumber'] as String,
        relation: json['relation'] == null ? null : json['relation'] as String,
      );


  Map<String, dynamic> toJson() => {
    'id' : id,
    'image' : image,
    'name' : name,
    'email' : email,
    'address' : address,
    'age' : age,
    'birthDate' :birthDate,
    'relation' : relation == null ? null : relation,
    'phoneNumber' : phoneNumber == null ? null : phoneNumber,
  };
}
