class Document {
  Document({
    this.id,
    this.name,
    this.images,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json['id'].toString(),
    name: json['name'] as String,
    images: json['images'] as String,
  );

  String? id;
  String? name;
  String? images;

  Map<String, dynamic> toJson() => {
    'id': id,
    'bondName': name,
    'images': images,
  };
}
