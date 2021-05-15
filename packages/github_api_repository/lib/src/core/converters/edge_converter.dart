import 'package:github_api_repository/src/domain/domain.dart' show Edge;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show EdgeDto;
import 'package:json_annotation/json_annotation.dart';

class EdgeConverter implements JsonConverter<List<Edge?>, List<Object?>?> {
  /// * [issue 884](https://github.com/google/json_serializable.dart/issues/884)
  ///
  /// Generated argument for nullable argument in fromJson is not nullable
  ///
  /// So instead of declaring json as
  /// ```dart
  ///  Map<String, dynamic>?
  /// ```
  /// we should declare it as
  /// ```dart
  ///  Map?
  /// ```
  ///
  /// TODO: Check status of this issue
  const EdgeConverter();

  @override
  List<Edge?> fromJson(List<Object?>? json) {
    if (json == null || json.isEmpty) {
      return [];
    }
    return json
        .map(
            (edge) => EdgeDto.fromJson(edge as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  List<Object?> toJson(List<Edge?>? edges) {
    if (edges == null || edges.isEmpty) {
      return [];
    }
    return edges.map((edge) => EdgeDto.fromDomain(edge!).toJson()).toList();
  }
}
