import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show EdgeConverter;
import 'package:github_api_repository/src/domain/domain.dart';

part 'issues_dto.freezed.dart';
part 'issues_dto.g.dart';

@freezed
class IssuesDto with _$IssuesDto {
  const IssuesDto._();

  factory IssuesDto({
    required int totalCount,
    @EdgeConverter() @JsonKey(name: 'edges') required List<Edge?> issues,
  }) = _IssuesDto;

  factory IssuesDto.fromDomain(Issues issues) =>
      IssuesDto(issues: issues.edges, totalCount: issues.totalCount);

  factory IssuesDto.fromJson(Map<String, dynamic> json) =>
      _$IssuesDtoFromJson(json);

  Issues toDomain() => Issues(edges: issues, totalCount: totalCount);
}
