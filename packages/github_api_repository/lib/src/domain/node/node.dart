import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/author/author.dart';

part 'node.freezed.dart';

@freezed
class Node with _$Node {
  const factory Node({
    required String id,
    required String createdAt,
    String? updatedAt,
    String? closedAt,
    int? number,
    Author? author,
    String? name,
    String? bodyText,
    String? title,
    String? state,
    bool? isCached,
  }) = _Node;
}
