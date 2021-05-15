import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show NodeConverter;
import 'package:github_api_repository/src/domain/domain.dart';

part 'edge_dto.freezed.dart';
part 'edge_dto.g.dart';

@freezed
class EdgeDto with _$EdgeDto {
  const EdgeDto._();

  const factory EdgeDto({
    required String cursor,
    @NodeConverter() required Node node,
  }) = _EdgeDto;

  factory EdgeDto.fromDomain(Edge edge) =>
      EdgeDto(cursor: edge.cursor, node: edge.node);

  factory EdgeDto.fromJson(Map<String, dynamic> json) =>
      _$EdgeDtoFromJson(json);

  Edge toDomain() => Edge(cursor: cursor, node: node);
}
