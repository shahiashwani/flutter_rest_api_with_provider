import 'enum.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse.loading(this.message) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.success;
  ApiResponse.error(this.message) : status = Status.failed;
  ApiResponse.noInternet(this.message) : status = Status.noInternet;
  ApiResponse.noStatus(this.message):status=Status.none;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  ApiResponse();
}

