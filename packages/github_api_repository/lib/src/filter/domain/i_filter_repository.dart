import 'package:github_api_repository/src/filter/domain/filter.dart';

abstract class IFilterRepository {
  bool hasStateFilter(Filter filter);
  bool hasAuthorFilter(Filter filter);

  Filter getFiltersFromString(String string);
}
