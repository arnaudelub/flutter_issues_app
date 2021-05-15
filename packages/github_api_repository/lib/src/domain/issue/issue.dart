import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/domain/author/author.dart';
import 'package:github_api_repository/src/domain/edge_parent/edge_parent.dart';

part 'issue.freezed.dart';

@freezed
class Issue with _$Issue {
  const factory Issue(
      {required String id,
      required Author? author,
      required String title,
      required String state,
      int? number,
      required String createdAt,
      required String updatedAt,
      String? closedAt,
      required EdgeParent? comments,
      required EdgeParent? labels}) = _Issue;

  factory Issue.empty() => const Issue(
      id: '',
      author: Author(login: ''),
      title: '',
      state: '',
      number: 0,
      createdAt: '',
      labels: null,
      comments: null,
      updatedAt: '');
}
