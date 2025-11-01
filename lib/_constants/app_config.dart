class AppConfig {
  static final title = "Start Project";
  static final bool isDebug = false;
  // static const String apiUrl = "https://mlm-online.gruper.co/api"; // DEBUG
  static const String apiUrl = "https://api.binghan.id/api"; // PRODUCTION
  // static const String apiUrl = "http://10.236.169.42:8000/api"; // DEV LOCAL
  static Map<String, String> header = {"Content-Type": "application/json"};
  static int timeoutRequest = 30;
  static String playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.gruper.binghan_mob";
  static String appStoreUrl = "";
}
