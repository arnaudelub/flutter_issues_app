import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/domain.dart';

part 'author_dto.freezed.dart';
part 'author_dto.g.dart';

@freezed
class AuthorDto with _$AuthorDto {
  const AuthorDto._();
  factory AuthorDto({
    required String login,
    required String? avatarUrl,
  }) = _AuthorDto;

  factory AuthorDto.fromDomain(Author author) =>
      AuthorDto(login: author.login, avatarUrl: author.avatarUrl);
  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  Author toDomain() => Author(login: login, avatarUrl: avatarUrl);
}
