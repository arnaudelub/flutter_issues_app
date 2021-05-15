import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
class Filter with _$Filter {
  const factory Filter({
    String? states,
    String? author,
  }) = _Filter;
}
