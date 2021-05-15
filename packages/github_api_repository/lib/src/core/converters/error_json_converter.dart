import 'package:github_api_repository/src/domain/domain.dart' show GqlError;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show GqlErrorDto;
import 'package:json_annotation/json_annotation.dart';

class ErrorJsonConverter implements JsonConverter<GqlError?, Map?> {
  /// * [issue 884](https://github.com/google/json_serializable.dart/issues/884)
  ///
  /// Generated argument for nullable argument in fromJson is not nullable
  ///
  /// So instead of declaring json as
  /// ```dart
  ///  Map<String, dynamic>?
  /// ```
  /// we should declare it as
  /// ```dart
  ///  Map?
  /// ```
  ///
  /// TODO: Check status of this issue
  const ErrorJsonConverter();

  @override
  GqlError? fromJson(Map? json) {
    if (json == null) {
      return null;
    }
    return GqlErrorDto.fromJson(json as Map<String, dynamic>).toDomain();
  }

  @override
  Map<String, dynamic>? toJson(GqlError? error) {
    if (error == null) {
      return null;
    }
    return GqlErrorDto.fromDomain(error).toJson();
  }
}
