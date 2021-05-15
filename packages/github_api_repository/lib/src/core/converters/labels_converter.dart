import 'package:github_api_repository/src/domain/domain.dart' show EdgeParent;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show LabelsDto;
import 'package:json_annotation/json_annotation.dart';

class LabelsConverter implements JsonConverter<EdgeParent?, Map?> {
  const LabelsConverter();

  @override
  EdgeParent? fromJson(Map? json) => json == null
      ? null
      : LabelsDto.fromJson(json as Map<String, dynamic>).toDomain();

  @override
  Map<String, dynamic>? toJson(EdgeParent? parent) =>
      parent == null ? null : LabelsDto.fromDomain(parent).toJson();
}
