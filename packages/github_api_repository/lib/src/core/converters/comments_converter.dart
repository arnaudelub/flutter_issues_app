import 'package:github_api_repository/src/domain/domain.dart' show EdgeParent;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show CommentsDto;
import 'package:json_annotation/json_annotation.dart';

class CommentsConverter implements JsonConverter<EdgeParent?, Map?> {
  const CommentsConverter();

  @override
  EdgeParent? fromJson(Map? json) => json == null
      ? null
      : CommentsDto.fromJson(json as Map<String, dynamic>).toDomain();

  @override
  Map<String, dynamic>? toJson(EdgeParent? parent) =>
      parent == null ? null : CommentsDto.fromDomain(parent).toJson();
}
