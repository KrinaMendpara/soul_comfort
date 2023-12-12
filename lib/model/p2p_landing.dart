class P2PLanding {
  P2PLanding({
    this.id,
    this.p2PLanding,
    this.others,
    this.images,
    this.notes,
  });

  factory P2PLanding.fromJson(Map<String, dynamic> json) => P2PLanding(
        id: json['id'].toString(),
        p2PLanding: json['p2PLanding'].toString(),
        others: json['others'] == null ? null : json['others'] as String,
        notes: json['notes'] == null ? null : json['notes'] as String,
        images:
            (List<String>.from(json['images'].map((x) => x) as List).isEmpty)
                ? []
                : List<String>.from(json['images'].map((x) => x) as List),
      );

  String? id;
  String? p2PLanding;
  String? others;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'p2PLanding': p2PLanding,
        'others': others,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
