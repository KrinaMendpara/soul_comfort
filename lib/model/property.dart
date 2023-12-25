class Property {
  Property({
    this.id,
    this.propertyName,
    this.propertyAddress,
    this.images,
    this.notes,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json['id'].toString(),
        propertyName: json['propertyName'].toString(),
        propertyAddress: json['propertyAddress'].toString(),
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? propertyName;
  String? propertyAddress;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'propertyName': propertyName,
        'propertyAddress': propertyAddress,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
