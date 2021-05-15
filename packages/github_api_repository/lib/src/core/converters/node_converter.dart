import 'package:github_api_repository/src/domain/domain.dart' show Node;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show NodeDto;
import 'package:json_annotation/json_annotation.dart';

class NodeConverter implements JsonConverter<Node, Map<String, dynamic>> {
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
  const NodeConverter();

  @override
  Node fromJson(Map<String, dynamic> json) => NodeDto.fromJson(json).toDomain();

  @override
  Map<String, dynamic> toJson(Node node) => NodeDto.fromDomain(node).toJson();
}
