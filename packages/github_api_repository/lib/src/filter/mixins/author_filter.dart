mixin AuthorFilter {
  String getAuthorFromFilter(String filter) => filter.split(':')[1];
}
