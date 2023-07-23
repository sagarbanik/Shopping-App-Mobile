class Constants{
  static const String APP_NAME = "Food Paradise";
  static const int APP_VERSION = 1;
  //static const String BASE_URL = "http://mvs.bslmeiyu.com";
  static const String BASE_URL = "http://192.168.0.139:8000";
  //static const String BASE_URL = "http://192.168.0.189:8000";
  //static const String BASE_URL = "http://192.168.0.139:8000";
  static const String POPULAR_PRODUCT_ENDPOINT = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_ENDPOINT = "/api/v1/products/recommended";
  static const String DRINKS_PRODUCT_ENDPOINT = "/api/v1/products/drinks";
  static const String UPLOAD_URL = "/uploads/";

  //Google map
  static const String GEOCODE_URL = "/api/v1/config/geocode-api";
  static const String USER_ADDRESS = "user_address";

  //Auth
  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USER_INFO_URL = "/api/v1/customer/info";

  static const String TOKEN = "";

  //User Detail
  static const String PHONE = "";
  static const String PASSWORD = "";

  //Shared  Pref
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}