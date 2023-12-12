class Property {
  Property({
    this.id,
    this.residentName,
    this.residentAddress,
    this.images,
    this.notes,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json['id'].toString(),
        residentName: json['residentName'].toString(),
        residentAddress: json['residentAddress'].toString(),
        images:
            (List<String>.from(json['images'].map((x) => x) as List).isEmpty)
                ? []
                : List<String>.from(json['images'].map((x) => x) as List).toList(),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? residentName;
  String? residentAddress;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'residentName': residentName,
        'residentAddress': residentAddress,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
