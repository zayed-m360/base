class AppUrls {
  // static const String baseUrl = "http://192.168.0.158:9988/api/v1"; //!Local url
  static const String baseUrl = "http://192.168.0.244:9008/api/v1"; //!Server url

  static const String imageBaseUrl = 'https://m360-trabill.s3.ap-south-1.amazonaws.com/booking-expert-storage';

  static const String agencyToken = 'asdfasdmjbhfoiauhfeiuhewfa23a';


  static const String flightSearch   = '$baseUrl/booking/flight/search';
  static const String searchFilter   = '$baseUrl/booking/flight/filter';
  static const String revalidation   = '$baseUrl/booking/flight/revalidate/v2';
  static const String login          = '$baseUrl/btoc/auth/login';
  static const String editProfile    = '$baseUrl/booking/profile';
  static const String signUp         = '$baseUrl/btoc/auth/registration';
  static const String sendOTP        = '$baseUrl/btoc/otp/send';
  static const String verifyOTP       = '$baseUrl/btoc/otp/match';
  static const String resetPassword  = '$baseUrl/btoc/auth/reset-password';
  static const String changePassword = '$baseUrl/booking/profile/change-password';
  static const String bookingRequest = '$baseUrl/booking/booking-request';

  //!for traveler
  static const String travelerList = '$baseUrl/booking/traveler';

  //!for common
  static const String airports = '$baseUrl/common/airport';
  // static const String sendOtp  = '$baseUrl/common/send-email-otp';
  // static const String matchOtp = '$baseUrl/common/match-email-otp';
  static const String country  = '$baseUrl/common/country';
  static const String city     = '$baseUrl/common/city?country_id=';

}
