import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show EdgeConverter;
import 'package:github_api_repository/src/domain/domain.dart' show Edge, Issues;

part 'issues_dto.freezed.dart';
part 'issues_dto.g.dart';

@freezed
class IssuesDto with _$IssuesDto {
  const IssuesDto._();

  factory IssuesDto({
    @EdgeConverter() @JsonKey(name: 'edges') required List<Edge?> issues,
  }) = _IssuesDto;

  factory IssuesDto.fromDomain(Issues issues) =>
      IssuesDto(issues: issues.edges);

  factory IssuesDto.fromJson(Map<String, dynamic> json) =>
      _$IssuesDtoFromJson(json);

  Issues toDomain() => Issues(edges: issues);
}
