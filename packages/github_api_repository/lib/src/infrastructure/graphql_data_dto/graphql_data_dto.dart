import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show ErrorJsonConverter, IssuesJsonConverter, NullableIssueJsonConverter;
import 'package:github_api_repository/src/domain/domain.dart'
    show GqlData, GqlError, Issue, Issues;

part 'graphql_data_dto.freezed.dart';
part 'graphql_data_dto.g.dart';

@freezed
class GqlDataDto with _$GqlDataDto {
  const GqlDataDto._();
  @JsonSerializable(explicitToJson: true)
  factory GqlDataDto({
    @JsonKey(includeIfNull: false) @IssuesJsonConverter() Issues? issues,
    @JsonKey(includeIfNull: false) @NullableIssueJsonConverter() Issue? issue,
    @JsonKey(includeIfNull: false) @ErrorJsonConverter() GqlError? error,
  }) = _GqlDataDto;

  factory GqlDataDto.fromJson(Map<String, dynamic> json) =>
      _$GqlDataDtoFromJson(json);

  GqlData toDomain() => GqlData(issues: issues, issue: issue, error: error);
}
