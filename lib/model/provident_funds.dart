class ProvidentFunds {
  ProvidentFunds({
    this.id,
    this.epfName,
    this.ppfName,
    this.images,
    this.notes,
  });

  factory ProvidentFunds.fromJson(Map<String, dynamic> json) => ProvidentFunds(
        id: json['id'].toString(),
        epfName: json['epfName'] == null ? null : json['epfName'] as String,
        ppfName: json['ppfName'] == null ? null : json['ppfName'] as String,
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? epfName;
  String? ppfName;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'epfName': epfName == null ? null : epfName,
        'ppfName': ppfName == null ? null :ppfName,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
