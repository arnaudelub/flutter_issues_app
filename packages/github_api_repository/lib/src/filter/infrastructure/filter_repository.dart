import 'package:github_api_repository/src/filter/domain/filter.dart';
import 'package:github_api_repository/src/filter/domain/i_filter_repository.dart';
import 'package:github_api_repository/src/filter/infrastructure/filter_dto.dart';

class FilterRepository implements IFilterRepository {
  @override
  bool hasAuthorFilter(Filter filter) => filter.author != null;

  @override
  bool hasStateFilter(Filter filter) => filter.states != null;

  @override
  Filter getFiltersFromString(String string) =>
      FilterDto.fromString(string).toDomain();
}
