enum FetchStatus { idle, loading, success, error }

class FetchState<T> {
  final FetchStatus status;
  final T? data;
  final String? error;

  const FetchState({this.status = FetchStatus.idle, this.data, this.error});

  FetchState<T> copyWith({
    FetchStatus? status,
    T? data,
    String? error,
    bool clearError = false,
    bool clearData = false,
  }) => FetchState(
    status: status ?? this.status,
    data: clearData ? null : data ?? this.data,
    error: clearError ? null : error ?? this.error,
  );

  bool get isIdle => status == FetchStatus.idle;
  bool get isLoading => status == FetchStatus.loading;
  bool get isSuccess => status == FetchStatus.success;
  bool get isError => status == FetchStatus.error;
}
