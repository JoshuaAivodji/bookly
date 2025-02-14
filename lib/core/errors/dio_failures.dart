import 'package:bookly/core/errors/request_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class DioErrorHandler {

  static Either<Failure, T> handle<T>({
    required DioException error,
    T Function(dynamic data)? successHandler,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Left(NetworkFailure(
            message: error.message ?? 'Délai de connexion dépassé',
            statusCode: error.response?.statusCode));

      case DioExceptionType.receiveTimeout:
        return Left(NetworkFailure(
            message: error.message ?? 'Délai de réception dépassé',
            statusCode: error.response?.statusCode));

      case DioExceptionType.sendTimeout:
        return Left(NetworkFailure(
            message: error.message ?? 'Délai d\'envoi dépassé',
            statusCode: error.response?.statusCode));

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return Left(NetworkFailure(
            message: error.message ?? 'Requête annulée',
            statusCode: error.response?.statusCode));

      case DioExceptionType.connectionError:
        return Left(NetworkFailure(
            message: error.message ?? 'Erreur de connexion réseau',
            statusCode: error.response?.statusCode));

      case DioExceptionType.badCertificate:
        return Left(NetworkFailure(
            message: error.message ?? 'Erreur de certificat SSL',
            statusCode: error.response?.statusCode));

      case DioExceptionType.unknown:
        return Left(NetworkFailure(
            message: error.message ?? 'Erreur réseau inconnue',
            statusCode: error.response?.statusCode));
    }
  }

  static Either<Failure, T> _handleBadResponse<T>(DioException error) {
    final Response<dynamic>? response = error.response;
    final int? statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
        return Left(ServerFailure(
            message: error.message ?? 'Requête invalide',
            errorCode: 'BAD_REQUEST'));

      case 401:
        return Left(ServerFailure(
            message: error.message ?? 'Non autorisé',
            errorCode: 'UNAUTHORIZED'));

      case 403:
        return Left(ServerFailure(
            message: error.message ?? 'Accès interdit',
            errorCode: 'FORBIDDEN'));

      case 404:
        return Left(ServerFailure(
            message: error.message ?? 'Ressource non trouvée',
            errorCode: 'NOT_FOUND'));

      case 500:
        return Left(ServerFailure(
            message: error.message ?? 'Erreur serveur interne',
            errorCode: 'INTERNAL_SERVER_ERROR'));

      default:
        return Left(NetworkFailure(
            message: error.message ?? 'Erreur réseau inattendue',
            statusCode: statusCode));
    }
  }

  static Either<Failure, T> handleError<T>(Response response) {
    final int? statusCode = response.statusCode;
    final data = response.data;

    String errorMessage =
        data["message"] ?? "Erreur lors du traitement. Statut: $statusCode";
    final errors = data["error"];

    if (errors != null) {
      if (errors is Map) {
        final List<String> errorMessages = <String>[];
        (errors).forEach((key, value) {
          errorMessages.addAll(value.map<String>((msg) => "$msg"));
        });
        errorMessage = errorMessages.join('\n');
      } else if (errors is String) {
        errorMessage = errorMessage;
      }
    }

    switch (statusCode) {
      case 400:
        return Left(ServerFailure(
          message: errorMessage,
          errorCode: 'BAD_REQUEST',
        ));
      case 401:
        return Left(ServerFailure(
          message: errorMessage,
          errorCode: 'UNAUTHORIZED',
        ));
      case 403:
        return Left(ServerFailure(
          message: errorMessage,
          errorCode: 'FORBIDDEN',
        ));
      case 404:
        return Left(ServerFailure(
          message: errorMessage,
          errorCode: 'NOT_FOUND',
        ));
      case 500:
        return Left(ServerFailure(
          message: errorMessage,
          errorCode: 'INTERNAL_SERVER_ERROR',
        ));
      default:
        return Left(NetworkFailure(
          message: errorMessage,
          statusCode: statusCode,
        ));
    }
  }
}
