import 'package:dartz/dartz.dart';
import 'package:spotify/src/data/models/auth/user_model.dart';

abstract class AuthRepository {
  Future<Either> register(UserModel user);

  Future<Either> signin(UserModel user);
}
