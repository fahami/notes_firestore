import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String noHape;
  final String address;

  const User(
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.noHape,
    this.address,
  );

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        password,
        noHape,
        address,
      ];
}
