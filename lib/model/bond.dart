class Bonds {
  Bonds({
    required this.id,
    required this.bondName,
    required this.bondDetails,
    this.images,
    this.notes,
  });

  factory Bonds.fromJson(Map<String, dynamic> json) => Bonds(
        id: json['id'].toString(),
        bondName: json['bondName'] as String,
        bondDetails: json['bondDetails'] as String,
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String id;
  String bondName;
  String bondDetails;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bondName': bondName,
        'bondDetails': bondDetails,
        'notes': notes == null ? null : notes,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
      };
}
