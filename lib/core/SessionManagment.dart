import 'package:get_storage/get_storage.dart';

class SessionManagement {
  static const String APP_KEY = "E-Sentmentanalysis";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EXPIRES_KEY = "expires_at";
  static const String IS_GUEST = "is_guest";
  static const String IS_USER = "is_user";
  static late GetStorage _box;

  static Future<GetStorage> init() async {
    await GetStorage.init(APP_KEY);
    _box = GetStorage(APP_KEY);
    return _box;
  }

  static String? get refreshToken => _box.read(REFRESH_TOKEN);
  static String? get expiryDate => _box.read(EXPIRES_KEY);


  static bool get isGuest => _box.read(IS_GUEST) ?? false;

  static bool get isUser => _box.read(IS_USER) ?? false;
}