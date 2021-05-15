import 'package:github_api_repository/src/domain/domain.dart' show Issues;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show IssuesDto;
import 'package:json_annotation/json_annotation.dart';

class IssuesJsonConverter implements JsonConverter<Issues?, Map?> {
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
  const IssuesJsonConverter();

  @override
  Issues? fromJson(Map? json) {
    if (json == null) {
      return null;
    }
    return IssuesDto.fromJson(json as Map<String, dynamic>).toDomain();
  }

  @override
  Map<String, dynamic>? toJson(Issues? issues) =>
      issues == null ? null : IssuesDto.fromDomain(issues).toJson();
}
