mixin FilterSplitter {
  List<String> getListFromFilter(String filter) => filter.split(':');
}
