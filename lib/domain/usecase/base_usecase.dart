import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> call(In params);
}
// use case da byakhod mnk type w yrg3 type tany 