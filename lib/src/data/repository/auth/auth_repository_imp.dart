import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/api/auth/auth_api.dart';
import 'package:spotify/src/data/models/auth/user_model.dart';
import 'package:spotify/src/logic/repository/auth/auth_repository.dart';


@Singleton(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  @override
  Future<Either> register(UserModel user) async {
    return await getIt<AuthApi>().register(user);
  }

  @override
  Future<Either> signin(UserModel user) async  {

    return await getIt<AuthApi>().signin(user);
  }
}
