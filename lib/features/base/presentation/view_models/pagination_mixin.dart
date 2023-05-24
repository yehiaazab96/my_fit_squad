import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';

mixin PaginationUtils {
  int page = 1;
  bool hasNext = true;
  bool isPerformingRequest = false;
  reset() {
    page = 1;
    hasNext = true;
  }

  checkHasNext(List li, {int limit = 10}) {
    hasNext = li.isNotEmpty && li.length >= limit;
  }

  checkPerformRequest({bool refresh = false}) {
    return isPerformingRequest || !(refresh || hasNext);
  }

  void dataState<T>(BaseState<List<T>> state, List<T>? currList) {
    state.isLoading = false;
    state.data = currList ?? [];
    state.hasNoData = currList?.isEmpty ?? false;
    state.hasNoConnection = false;
  }
}
