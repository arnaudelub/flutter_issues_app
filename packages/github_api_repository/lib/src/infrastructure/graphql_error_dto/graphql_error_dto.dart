import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/domain.dart' show GqlError;

part 'graphql_error_dto.freezed.dart';
part 'graphql_error_dto.g.dart';

@freezed
class GqlErrorDto with _$GqlErrorDto {
  const GqlErrorDto._();

  factory GqlErrorDto({
    required String type,
    required String message,
  }) = _GqlErrorDto;

  factory GqlErrorDto.fromDomain(GqlError error) =>
      GqlErrorDto(type: error.type, message: error.message);

  factory GqlErrorDto.fromJson(Map<String, dynamic> json) =>
      _$GqlErrorDtoFromJson(json);

  GqlError toDomain() => GqlError(type: type, message: message);
}
