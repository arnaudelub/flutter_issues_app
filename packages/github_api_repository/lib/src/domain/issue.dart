import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue.freezed.dart';

@freezed
class Issues with _$Issues {
  const factory Issues({
    required Edges edges,
  }) = _Issues;
}

@freezed
class Edges with _$Edges {
  const factory Edges({
    required List<Issue?> issues,
  }) = _Edges;

  factory Edges.empty() => const Edges(issues: []);
}

@freezed
class Issue with _$Issue {
  const factory Issue({
    required String id,
    required Author author,
    required String title,
    required String state,
    required String createdAt,
    required String updatedAt,
    String? closedAt,
  }) = _Issue;
}

@freezed
class Author with _$Author {
  const factory Author({
    required String login,
  }) = _Author;
}
