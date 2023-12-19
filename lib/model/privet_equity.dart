class PrivetEquity {
  PrivetEquity({
    this.id,
    this.equityName,
    this.others,
    this.images,
    this.notes,
  });

  factory PrivetEquity.fromJson(Map<String, dynamic> json) => PrivetEquity(
        id: json['id'].toString(),
        equityName: json['equityName'].toString(),
        others: json['others'] == null ? null : json['others'] as String,
        notes: json['notes'] == null ? null : json['notes'] as String,
        images: List<String>.from(json['images'] as List),
      );

  String? id;
  String? equityName;
  String? others;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'equityName': equityName,
        'others': others,
        'notes': notes == null ? null : notes,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
      };
}
