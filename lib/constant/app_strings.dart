class AppStrings {
  static const String baseUrl = 'https://wrwvg6px-9000.inc1.devtunnels.ms/api';

  ////auth
  static const String signInEndPoint = '/auth/login';
  static const String signUpEndPoint = '/auth/register';
  static const String verifyOtpEndPoint = '/auth/verify';
  static const String resendOtpEndPoint = '/auth/resendOtp';
  static const String forgotPasswordEndPoint = '/auth/forget-password';
  static const String forgotPasswordVerifyEndPoint =
      '/auth/forget-password/verification';
  static const String changePasswordEndPoint = '/auth/change-password';
  static const String resetPasswordEndPoint = '/auth/reset-password';
  static const String logOutEndPoint = '/auth/logout';

  //User URL
  static const String createProfileEndPoint = '/auth/create_profile';
  static const String socialLogin = '/auth/login/oauth';
  static const String getMeEndPoint = '/user/getme';
  static const String updateLocationEndPoint = '/user/update_location';

  //home
  static const String postAdEndPoint = '/home/post_ad';
  static const String editAdEndPoint = '/home/edit_ad';
}
