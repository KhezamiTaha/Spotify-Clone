import 'package:injectable/injectable.dart';
import 'package:spotify/core/usecases/abstract_usecase.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/models/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/src/logic/repository/auth/auth_repository.dart';


@Singleton()
class SignInUsecase implements UseCase<Either, UserModel> {
  @override
  Future<Either> call({UserModel? params}) {
    return getIt<AuthRepository>().signin(params!);
  }
}
