class Property {
  Property({
    required this.propertyName,
    required this.propertyAddress,
    required this.pinCode,
    required this.id,
    required this.percentageOfOwnership,
    this.images,
    this.notes,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json['id'].toString(),
        propertyName: json['propertyName'].toString(),
        propertyAddress: json['propertyAddress'].toString(),
        pinCode: json['pinCode'].toString(),
        percentageOfOwnership: json['PercentageOfOwnership'].toString(),
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List).toList(),
        notes: json['notes'] == null ? null : json['notes'].toString(),
      );

  String id;
  String propertyName;
  String pinCode;
  String percentageOfOwnership;
  String propertyAddress;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'propertyName': propertyName,
        'propertyAddress': propertyAddress,
        'pinCode': pinCode,
        'PercentageOfOwnership': percentageOfOwnership,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)).toString(),
        'notes': notes == null ? null : notes,
      };
}
