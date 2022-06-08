import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String? name;
  final String? email;
  User(this.id, this.name, this.email);

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
