// Toutes les requetes existantes
enum RequestsName {
  logIn,
  register,
  isUserExists,
}

class ApiConfig {
  static String get prodBaseUrl => "";
  static String get debugBaseUrl => "localhost:3000";

  /// Nous definissons le chemin de chaque requettes
  static final Map<RequestsName, String> requests = {
    RequestsName.logIn: '/login',
  };

  static String? requestToString(RequestsName request) => requests[request];
}
