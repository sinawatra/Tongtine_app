class AppConstants {
  static const String baseURLDev = 'https://tongtin.onrender.com/';
  static const String baseURlStaging = 'https://tongtin.onrender.com/';
  static const String baseURLProd = 'https://tongtin.onrender.com/';


  //random 
  static const String emailSupport = "support@suntel.io";
  static const String telegramSupport = "https://t.me/bEasy_Cs";
  static const String phoneSupport = "+855 10 957 098";
  
  //Authentication
  static const String register = "/api/auth/register";
  static const String refreshtoken = 'api/v1/auth/refresh';
  static const String submitKycDocuments = "api/v1/kyc/documents";
  static const String extractId = "api/v1/kyc/extract-id";
  static const String postFCMToken = "api/v1/partners/device-token";
  static const String addWorkExperience = "api/v1/kyc/work-experience";
  static const String login = "/api/auth/login";
  
  //Service Preferences
  static const String servicePerferences = 'api/v1/partners/categories';


  //profile information 
  static const String getProfileDetails = "api/v1/partners/profile";
  static const String updateAddress = "api/v1/partners/address";
  static const String updateProfile = "api/v1/partners/profile";
  static const String availableSchedule = "api/v1/partners/availability";
  static const String addTimeOff = "api/v1/partners/time-off";
  static const String removeTimeOff = "api/v1/partners/time-off/";
  static const String updateAvailability = "api/v1/partners/availability";
  static const String deleteAccount  = "api/v1/partners/account";

  //chat
  static const String chatBaseUrl = "https://api-stg.bnow.app/";
  static const String chatToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsInBob25lIjoiOTY1NDI1OTg5IiwiaWF0IjoxNzcxNDY4MzE0LCJleHAiOjE4MDMwMjU5MTR9.TOH2ivxWSxxQCG_zJaaihKy-6FSt_g3Jw6cJdpsDYJc";
  static const String getChatDetails = "api/message/";
  static const String getAllChats = "api/chat";
  static const String sendMessage = "api/message/newMessage";
  static const String uploadMedia = "api/media/upload";


  //order
  static const String listingOrder = "api/v1/orders";
  static const String jobDetails = "api/v1/orders/";


  //call 
  static const int appID = 24754844;
  static const String appSign = "a552f04495fb5fc30c15c9d0a1cb45579462ac0978da86620666447b14f72a7c";


  //notification 
  static const String getNotification = "api/v1/notifications";
  static const String markNotificationAsRead = "api/v1/notifications";


  
  
}