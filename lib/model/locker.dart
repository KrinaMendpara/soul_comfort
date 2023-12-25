class Locker {
  Locker({
    this.id,
    this.lockerName,
    this.lockerAddress,
    this.images,
    this.notes,
  });

  factory Locker.fromJson(Map<String, dynamic> json) => Locker(
        id: json['id'].toString(),
        lockerName: json['lockerName'].toString(),
        lockerAddress: json['lockerAddress'].toString(),
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? lockerName;
  String? lockerAddress;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'lockerName': lockerName,
        'lockerAddress': lockerAddress,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
