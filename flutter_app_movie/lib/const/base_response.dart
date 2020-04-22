abstract class BaseResponse {
  BaseResponse.fromJson(Map<String, dynamic> json);
  BaseResponse.withError(String errorValue);
}