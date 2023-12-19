class Collectible {
  Collectible({
    this.id,
    this.art,
    this.nft,
    this.notes,
    this.images,
  });

  factory Collectible.fromJson(Map<String, dynamic> json) => Collectible(
        id: json['id'].toString(),
        art: json['art'] == null ? null : json['art'] as String,
        nft: json['nft'] == null ? null : json['nft'] as String,
        images: List<String>.from(json['images'] as List),
        notes: json['notes'] == null ? null : json['notes'] as String,
      );

  String? id;
  String? art;
  String? nft;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'art': art,
        'nft': nft,
        'notes': notes == null ? null : notes,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
      };
}
