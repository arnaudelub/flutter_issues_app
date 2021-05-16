import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show EdgeConverter;
import 'package:github_api_repository/src/domain/domain.dart';

part 'comments_dto.freezed.dart';
part 'comments_dto.g.dart';

@freezed
class CommentsDto with _$CommentsDto {
  const CommentsDto._();

  factory CommentsDto({
    required int totalCount,
    @JsonKey(name: 'edges') @EdgeConverter() required List<Edge?> comments,
  }) = _CommentsDto;

  factory CommentsDto.fromDomain(EdgeParent comments) =>
      CommentsDto(comments: comments.edges, totalCount: comments.totalCount);

  factory CommentsDto.fromJson(Map<String, dynamic> json) =>
      _$CommentsDtoFromJson(json);

  EdgeParent toDomain() => EdgeParent(edges: comments, totalCount: totalCount);
}
