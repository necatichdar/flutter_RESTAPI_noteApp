class APIResponse<T> {
  T data; //Gelen veri
  //Hata Tespiti Icin
  bool error;
  String errorMessage;

  APIResponse({this.data, this.errorMessage, this.error = false});
}