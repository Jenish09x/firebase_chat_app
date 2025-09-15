part of 'model.dart';

abstract interface class UserDocumentField {
  static const String email = 'email';
  static const String createdAt = 'createdAt';
}

class UserDocument extends Equatable {
  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  const UserDocument({
    this.id,
    this.email,
    this.password,
    this.name,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
    };
  }

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
                ? (json['createdAt'] as Timestamp).toDate()
                : DateTime.tryParse(json['createdAt'].toString()))
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
                ? (json['updatedAt'] as Timestamp).toDate()
                : DateTime.tryParse(json['updatedAt'].toString()))
          : null,
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [id, email, password, name, photoUrl, createdAt, updatedAt, status];

  UserDocument copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) {
    return UserDocument(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }
}
