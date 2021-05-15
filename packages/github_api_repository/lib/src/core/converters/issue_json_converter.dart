import 'package:github_api_repository/src/domain/domain.dart' show Issue;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show IssueDto;
import 'package:json_annotation/json_annotation.dart';

class IssueJsonConverter implements JsonConverter<Issue, Map<String, dynamic>> {
  const IssueJsonConverter();

  @override
  Issue fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Issue.empty();
    }
    return IssueDto.fromJson(json).toDomain();
  }

  @override
  Map<String, dynamic> toJson(Issue? issue) {
    if (issue == null) {
      return {};
    }
    return IssueDto.fromDomain(issue).toJson();
  }
}
