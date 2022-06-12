import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes/features/auth/domain/entities/user.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel(int id, String? name, String? email) : super(id, name, email);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
