class ApiState<T> {
  final ApiStatus status;
  final T? data;
  final String? error;
  final String? empty;

  const ApiState._({required this.status, this.data, this.error, this.empty});

  factory ApiState.loading() => ApiState._(status: ApiStatus.LOADING);
  factory ApiState.completed(T data) => ApiState._(status: ApiStatus.COMPLETED, data: data);
  factory ApiState.error(String error) => ApiState._(status: ApiStatus.ERROR, error: error);
  factory ApiState.empty(String empty) => ApiState._(status: ApiStatus.EMPTY, empty: empty);
}

enum ApiStatus { LOADING, COMPLETED, ERROR, EMPTY }
