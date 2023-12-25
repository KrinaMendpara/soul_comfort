class BankAccount {
  BankAccount({
    this.id,
    this.bankName,
    this.accountNumber,
    this.branchName,
    this.accountType,
    this.ifscCode,
    this.images,
    this.notes,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json['id'].toString(),
        bankName: json['bankName'].toString(),
        accountNumber: json['accountNumber'].toString(),
        branchName: json['branchName'].toString(),
        accountType:
            json['accountType'] == null ? null : json['accountType'] as String,
        ifscCode: json['ifscCode'] == null ? null : json['ifscCode'] as String,
        notes: json['notes'] == null ? null : json['notes'] as String,
        images: List<String>.from(json['images'] as List) == null
            ? null
            : List<String>.from(json['images'] as List),
      );

  String? id;
  String? bankName;
  String? accountType;
  String? accountNumber;
  String? ifscCode;
  String? branchName;
  List<String>? images;
  String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'branchName': branchName,
        'accountType': accountType == null ? null : accountType,
        'ifscCode': ifscCode == null ? null : ifscCode,
        'images': List<dynamic>.from(images!.map((x) => x)).isEmpty
            ? []
            : List<dynamic>.from(images!.map((x) => x)),
        'notes': notes == null ? null : notes,
      };
}
