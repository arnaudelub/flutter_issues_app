import 'package:github_api_repository/src/domain/domain.dart' show Author;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show AuthorDto;
import 'package:json_annotation/json_annotation.dart';

class AuthorJsonConverter implements JsonConverter<Author?, Map?> {
  const AuthorJsonConverter();

  @override
  Author? fromJson(Map? json) {
    if (json == null) return null;
    return AuthorDto.fromJson(json as Map<String, dynamic>).toDomain();
  }

  @override
  Map<String, dynamic>? toJson(Author? author) =>
      author == null ? null : AuthorDto.fromDomain(author).toJson();
}
