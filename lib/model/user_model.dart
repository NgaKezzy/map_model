import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/entity/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String name,
    required String id,
   required String birthday,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User.fromJson(toJson());
}
