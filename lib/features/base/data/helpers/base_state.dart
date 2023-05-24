import 'package:flutter/widgets.dart';

class BaseState<T> {
  bool isLoading;
  bool isPerformingRequest;
  bool actionSucceeded;
  String? successMessage;
  bool hasNoConnection;
  bool hasNoData;
  String? noDataMessage;
  IconData? noDataIcon;
  T data;

  BaseState(
      {
        this.isLoading = false,
        this.isPerformingRequest = false,
        this.actionSucceeded = false,
        this.successMessage,
        this.hasNoConnection = false,
        this.hasNoData = false,
        this.noDataMessage,
        this.noDataIcon,
        required this.data
      });

  BaseState<T> copyWith({
    bool? isLoading,
    bool? isPerformingRequest,
    bool? actionSucceeded,
    String? successMessage,
    bool? hasNoConnection,
    bool? hasNoData,
    String? noDataMessage,
    IconData? noDataIcon,
    T? data
  }){
    return BaseState(
        isLoading: isLoading ?? this.isLoading,
        isPerformingRequest: isPerformingRequest ?? this.isPerformingRequest,
        actionSucceeded: actionSucceeded ?? this.actionSucceeded,
        successMessage: successMessage ?? this.successMessage,
        hasNoConnection: hasNoConnection ?? this.hasNoConnection,
        hasNoData: hasNoData ?? this.hasNoData,
        noDataMessage: noDataMessage ?? this.noDataMessage,
        noDataIcon: noDataIcon ?? this.noDataIcon,
        data: data ?? this.data
    );
  }
}
