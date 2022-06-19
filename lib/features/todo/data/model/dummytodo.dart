import 'package:equatable/equatable.dart';

class Dummytodo extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;

  const Dummytodo({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
  });

  factory Dummytodo.fromJson(Map<String, dynamic> json) => Dummytodo(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };

  Dummytodo copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return Dummytodo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, name, email, password, role];
}
