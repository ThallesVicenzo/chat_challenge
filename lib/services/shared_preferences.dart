import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  void saveData(String nickname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }

  Future<String?> retrieveData(String nicknameKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nickname = prefs.getString(nicknameKey);
    print(nickname);

    return nickname;
  }
}
