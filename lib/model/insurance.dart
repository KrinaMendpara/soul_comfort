class Insurance {
  Insurance({
    this.id,
    this.insuranceName,
    this.other,
    this.images,
    this.notes,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
        id: json['id'].toString(),
        insuranceName: json['insuranceName'].toString(),
        other: json['other'].toString(),
        images:
            (List<String>.from(json['images'].map((x) => x) as List).isEmpty)
                ? []
                : List<String>.from(json['images'].map((x) => x) as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? insuranceName;
  String? other;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'insuranceName': insuranceName,
        'other': other,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}