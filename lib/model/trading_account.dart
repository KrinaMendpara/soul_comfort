class TradingAccount {
  TradingAccount({
    required this.id,
    required this.stock,
    required this.mutualFunds,
    this.images,
    this.notes,
  });

  factory TradingAccount.fromJson(Map<String, dynamic> json) => TradingAccount(
        id: json['id'].toString(),
        stock: json['stock'].toString(),
        mutualFunds: json['mutualFunds'].toString(),
        notes: json['notes'] == null ? null : json['notes'] as String,
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
      );

  String id;
  String stock;
  String mutualFunds;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'stock': stock,
        'mutualFunds': mutualFunds,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
