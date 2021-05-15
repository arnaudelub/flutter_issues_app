import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/graphql_error/graphql_error.dart';
import 'package:github_api_repository/src/domain/issue/issue.dart';
import 'package:github_api_repository/src/domain/issues/issues.dart';

part 'graphql_data.freezed.dart';

@freezed
class GqlData with _$GqlData {
  const factory GqlData({
    Issues? issues,
    Issue? issue,
    GqlError? error,
  }) = _GqlData;
}
