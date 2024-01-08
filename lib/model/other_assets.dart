class OtherAssets {
  OtherAssets({
    required this.id,
    required this.name,
    required this.details,
    this.images,
    this.notes,
  });

  factory OtherAssets.fromJson(Map<String, dynamic> json) => OtherAssets(
        id: json['id'].toString(),
        name: json['name'].toString(),
        details: json['details'].toString(),
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String id;
  String name;
  String details;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'details': details,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
