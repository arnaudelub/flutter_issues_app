import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/core/converters.dart'
    show EdgeConverter;
import 'package:github_api_repository/src/domain/domain.dart';

part 'labels_dto.freezed.dart';
part 'labels_dto.g.dart';

@freezed
class LabelsDto with _$LabelsDto {
  const LabelsDto._();

  factory LabelsDto({
    required int totalCount,
    @EdgeConverter() required List<Edge?> labels,
  }) = _LabelsDto;

  factory LabelsDto.fromDomain(EdgeParent labels) =>
      LabelsDto(labels: labels.edges, totalCount: labels.totalCount);

  factory LabelsDto.fromJson(Map<String, dynamic> json) =>
      _$LabelsDtoFromJson(json);

  EdgeParent toDomain() => EdgeParent(edges: labels, totalCount: totalCount);
}
