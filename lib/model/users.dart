class Users {
  Users({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.address,
    required this.age,
    required this.birthDate,
    this.isDeleteUser = false,
    this.phoneNumber,
    this.relation,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['id'].toString(),
        image: json['image'] == null ? null : json['image'] as String,
        name: json['name'].toString(),
        email: json['email'].toString(),
        address: json['address'].toString(),
        age: json['age'].toString(),
        birthDate: json['birthDate'].toString(),
        isDeleteUser:
            json['isDeleteUser'] as bool,
        phoneNumber:
            json['phoneNumber'] == null ? null : json['phoneNumber'] as String,
        relation: json['relation'] == null ? null : json['relation'] as String,
      );

  String id;
  String? image;
  String name;
  String address;
  String email;
  String? relation;
  String? phoneNumber;
  String age;
  String birthDate;
  bool isDeleteUser;

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image == null ? null : image,
        'name': name,
        'email': email,
        'address': address,
        'age': age,
        'birthDate': birthDate,
        'isDeleteUser': isDeleteUser,
        'relation': relation == null ? null : relation,
        'phoneNumber': phoneNumber == null ? null : phoneNumber,
      };
}
