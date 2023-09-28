import 'package:flutter/foundation.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';
import 'package:sqlite_flutter/models/user.dart';
// Import your DbHelper class

class UserProvider extends ChangeNotifier {
  User? _user;
  final DbHelper dbHelper = DbHelper(); // Create an instance of your DbHelper

  User? get user => _user;

  // Fetch user data by email
  Future<void> fetchUserByEmail(String email) async {
    final user = await dbHelper.getUserByUsername(email);
    if (user != null) {
      _user = user;
      notifyListeners(); // Notify listeners of the change in user data
    }
  }
}
