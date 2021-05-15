import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/node/node.dart';

part 'edge.freezed.dart';

@freezed
class Edge with _$Edge {
  const factory Edge({
    required String cursor,
    required Node node,
  }) = _Edge;
}
