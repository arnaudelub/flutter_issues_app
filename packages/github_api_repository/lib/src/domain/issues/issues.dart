import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/edge/edge.dart';

part 'issues.freezed.dart';

@freezed
class Issues with _$Issues {
  const factory Issues({
    required List<Edge?> edges,
  }) = _Issues;
}
