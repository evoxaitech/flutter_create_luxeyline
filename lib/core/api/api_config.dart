class ApiConfig {
  static const String baseUrl = 'https://130.210.46.232.sslip.io';

  static const String signup = '/api/auth/signup';
  static const String login = '/api/auth/login';
  static const String forgotPassword = '/api/auth/password/forgot';
  static const String verifyOtp = '/api/auth/password/verify-otp';
  static const String resetPassword = '/api/auth/password/reset';

  static const String properties = '/api/properties';
  static const String featured = '/api/properties/featured';
  static const String recommended = '/api/properties/recommended';
}