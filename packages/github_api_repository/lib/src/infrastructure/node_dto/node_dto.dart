import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show AuthorJsonConverter;
import 'package:github_api_repository/src/domain/domain.dart' show Author, Node;

part 'node_dto.freezed.dart';
part 'node_dto.g.dart';

@freezed
class NodeDto with _$NodeDto {
  const NodeDto._();

  factory NodeDto({
    required String id,
    required String createdAt,
    String? updatedAt,
    String? closedAt,
    int? number,
    @JsonKey(includeIfNull: false) @AuthorJsonConverter() Author? author,
    String? name,
    String? bodyText,
    String? title,
    String? state,
  }) = _NodeDto;

  factory NodeDto.fromJson(Map<String, dynamic> json) =>
      _$NodeDtoFromJson(json);

  factory NodeDto.fromDomain(Node node) => NodeDto(
        id: node.id,
        author: node.author,
        createdAt: node.createdAt,
        updatedAt: node.updatedAt,
        closedAt: node.closedAt,
        number: node.number,
        name: node.name,
        bodyText: node.bodyText,
        title: node.title,
        state: node.state,
      );
  Node toDomain() => Node(
        id: id,
        author: author,
        createdAt: createdAt,
        updatedAt: updatedAt,
        closedAt: closedAt,
        number: number,
        name: name,
        bodyText: bodyText,
        title: title,
        state: state,
      );
}
