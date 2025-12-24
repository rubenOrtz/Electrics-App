import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Error de caché']) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = 'Error de base de datos'])
      : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Error del servidor']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Error de conexión']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Datos inválidos'])
      : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Error desconocido']) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Elemento no encontrado'])
      : super(message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String message = 'No autorizado'])
      : super(message);
}
