import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/edge/edge.dart';

part 'edge_parent.freezed.dart';

@freezed
class EdgeParent with _$EdgeParent {
  const factory EdgeParent({
    required List<Edge?> edges,
  }) = _EdgeParent;
}
