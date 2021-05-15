import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show AuthorJsonConverter, CommentsConverter, LabelsConverter;
import 'package:github_api_repository/src/domain/domain.dart';

part 'issue_dto.freezed.dart';
part 'issue_dto.g.dart';

@freezed
class IssueDto with _$IssueDto {
  const IssueDto._();

  factory IssueDto({
    required String id,
    @AuthorJsonConverter() Author? author,
    required String title,
    required String state,
    required String? bodyText,
    @JsonKey(includeIfNull: false)
    @CommentsConverter()
        required EdgeParent? comments,
    @JsonKey(includeIfNull: false)
    @LabelsConverter()
        required EdgeParent? labels,
    @JsonKey(includeIfNull: false) int? number,
    required String createdAt,
    required String updatedAt,
    @JsonKey(includeIfNull: false) String? closedAt,
  }) = _IssueDto;

  factory IssueDto.fromJson(Map<String, dynamic> json) =>
      _$IssueDtoFromJson(json);

  factory IssueDto.fromDomain(Issue issue) => IssueDto(
        id: issue.id,
        author: issue.author,
        title: issue.title,
        state: issue.state,
        bodyText: issue.bodyText,
        number: issue.number ?? 0,
        createdAt: issue.createdAt,
        updatedAt: issue.updatedAt,
        closedAt: issue.closedAt,
        labels: issue.labels,
        comments: issue.comments,
      );
  Issue toDomain() => Issue(
        id: id,
        author: author,
        number: number ?? 0,
        title: title,
        state: state,
        bodyText: bodyText,
        createdAt: createdAt,
        updatedAt: updatedAt,
        closedAt: closedAt ?? '',
        labels: labels,
        comments: comments,
      );
}
