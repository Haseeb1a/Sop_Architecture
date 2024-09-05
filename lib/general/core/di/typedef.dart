import 'package:dartz/dartz.dart';
import 'package:task_sop/general/core/main_faliures.dart';

typedef FutureResult<T> = Future<Either<MainFailure,T>>;

typedef StreamResult<T> = Stream<Either<MainFailure,T>>;

typedef UseResult<T> = Either<MainFailure, T>;

