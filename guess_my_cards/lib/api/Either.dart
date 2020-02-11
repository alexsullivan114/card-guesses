class NetworkResponse<L, R> {
  L error;
  R data;
  int statusCode;

  NetworkResponse._internal(this.error, this.data, this.statusCode);

  factory NetworkResponse.error(L left, int statusCode) {
    return NetworkResponse._internal(left, null, statusCode);
  }

  factory NetworkResponse.data(R right, int statusCode) {
    return NetworkResponse._internal(null, right, statusCode);
  }

  bool isSuccess() {
    return data != null;
  }

  @override
  String toString() {
    if (isSuccess()) {
      return "NetworkResponse success: $data";
    } else {
      return "NetworkResponse failure: $error";
    }
  }
}
