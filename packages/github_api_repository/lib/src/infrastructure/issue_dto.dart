import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/issue.dart';

part 'issue_dto.freezed.dart';
part 'issue_dto.g.dart';

@freezed
class IssuesDto with _$IssuesDto {
  const IssuesDto._();

  factory IssuesDto({
    @JsonKey(
      name: 'issues',
      fromJson: IssuesDto._edgesFromJson,
      toJson: IssuesDto._edgesToJson,
    )
        required Edges edges,
  }) = _IssuesDto;

  factory IssuesDto.fromJson(Map<String, dynamic> json) =>
      _$IssuesDtoFromJson(json);

  static Edges _edgesFromJson(Map<String, dynamic> json) =>
      EdgesDto.fromJson(json).toDomain();

  static Map<String, dynamic> _edgesToJson(Edges edges) => {'edges': edges};

  Issues toDomain() => Issues(edges: edges);
}

@freezed
class EdgesDto with _$EdgesDto {
  const EdgesDto._();

  factory EdgesDto({
    @Default([])
    @JsonKey(
      name: 'edges',
      fromJson: EdgesDto._issuesFromJson,
      toJson: EdgesDto._issuesToJson,
    )
        List<Issue?> issuesList,
  }) = _EdgesDto;

  factory EdgesDto.fromDomain(Edges? edges) =>
      EdgesDto(issuesList: edges!.issues);
  factory EdgesDto.fromJson(Map<String, dynamic> json) =>
      _$EdgesDtoFromJson(json);

  Edges toDomain() => Edges(issues: issuesList);

  static List<Issue> _issuesFromJson(List<dynamic?> json) {
    print(json);
    return json.isEmpty
        ? []
        : json
            .map<Issue>((issue) => IssueDto.fromJson(issue).toDomain())
            .toList();
  }

  static List<Map<String, dynamic>?> _issuesToJson(List<Issue?> issues) =>
      issues.isEmpty
          ? []
          : issues
              .map((issue) => IssueDto.fromDomain(issue!).toJson())
              .toList();
}

@freezed
class IssueDto with _$IssueDto {
  const IssueDto._();

  factory IssueDto({
    required String id,
    @JsonKey(fromJson: IssueDto._authorFromJson, toJson: IssueDto._authorToJson)
        required Author author,
    required String title,
    required String state,
    required String createdAt,
    required String updatedAt,
    @JsonKey(includeIfNull: false) String? closedAt,
  }) = _IssueDto;

  factory IssueDto.fromJson(Map<String, dynamic> json) =>
      _$IssueDtoFromJson(json['node']);

  factory IssueDto.fromDomain(Issue issue) => IssueDto(
      id: issue.id,
      author: issue.author,
      title: issue.title,
      state: issue.state,
      createdAt: issue.createdAt,
      updatedAt: issue.updatedAt,
      closedAt: issue.closedAt);
  Issue toDomain() => Issue(
      id: id,
      author: author,
      title: title,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      closedAt: closedAt);

  static Author _authorFromJson(Map<String, dynamic> json) =>
      AuthorDto.fromJson(json).toDomain();

  static Map<String, dynamic> _authorToJson(Author author) =>
      {'login': author.login};
}

@freezed
class AuthorDto with _$AuthorDto {
  const AuthorDto._();
  factory AuthorDto({
    required String login,
  }) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  Author toDomain() => Author(login: login);
}
