class NetworkResponse {
  final bool isSuccessful;
  final int statusCode;
  dynamic responseData;
  String errorMessage;

  NetworkResponse({
    required this.isSuccessful,
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Something went wrong",
  });
}
