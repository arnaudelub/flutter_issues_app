import 'package:freezed_annotation/freezed_annotation.dart';

part 'graphql_error.freezed.dart';

@freezed
class GqlError with _$GqlError {
  const factory GqlError({
    required String type,
    required String message,
  }) = _GqlError;
}
