class NetworkResponse<L, R> {
  L error;
  R data;

  NetworkResponse._internal(this.error, this.data);

  factory NetworkResponse.error(L left) {
    return NetworkResponse._internal(left, null);
  }

  factory NetworkResponse.data(R right) {
    return NetworkResponse._internal(null, right);
  }

  bool isSuccess() {
    return data != null;
  }
}
