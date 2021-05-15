import 'package:github_api_repository/src/domain/domain.dart' show Issue;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show IssueDto;
import 'package:json_annotation/json_annotation.dart';

class NullableIssueJsonConverter implements JsonConverter<Issue?, Map?> {
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
  const NullableIssueJsonConverter();

  @override
  Issue? fromJson(Map? json) {
    if (json == null) {
      return null;
    }
    return IssueDto.fromJson(json as Map<String, dynamic>).toDomain();
  }

  @override
  Map<String, dynamic>? toJson(Issue? issue) {
    if (issue == null) {
      return null;
    }
    return IssueDto.fromDomain(issue).toJson();
  }
}
