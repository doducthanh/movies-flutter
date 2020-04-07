
import 'package:flutter/services.dart';
import 'package:flutterappmovie/common/cache.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';
import 'package:flutterappmovie/utility/app_utility.dart';
import 'package:rxdart/rxdart.dart';

class AccountBloc {
  BehaviorSubject<String> _userNameObject = BehaviorSubject<String>();
  get getUserNameStream => _userNameObject.stream;

  BehaviorSubject<String> _emailObject = BehaviorSubject<String>();
  get getEmailStream => _emailObject.stream;

  BehaviorSubject<String> _passwordObject = BehaviorSubject<String>();
  get getPasswordStream => _passwordObject.stream;

  BehaviorSubject<Account> _accountObject = BehaviorSubject<Account>();
  get getAccountStream => _accountObject.stream;

  var _firebaseReposity = FirebaseRepository();

  bool validateUserName(String username) {
    if (username.isEmpty || (username == "")) {
      _userNameObject.sink.add("Tài khoản không được để trống");
      return false;
    } else {
      _userNameObject.sink.add(null);
      return true;
    }
  }

  bool validateEmail(String email) {
    if (email.isEmpty || (email == "")) {
      _emailObject.sink.add("Email không được để trống");
      return false;
    } else if (!email.contains("@")) {
      _emailObject.sink.add("Email không đúng định dạng");
      return true;
    } else {
      _emailObject.sink.add(null);
      return true;
    }
  }

  bool validatePassword(String password) {
    if (password.isEmpty || (password == "")) {
      _passwordObject.sink.add("Password không được để trống");
      return false;
    } else if (password.length < 6) {
      _passwordObject.sink.add("Password phải lớn hơn 6 ký tự");
      return false;
    } else {
      _passwordObject.sink.add(null);
      return true;
    }
  }

  ///reset trang thai textfiled ko hien thi loi nua
  void resetUsernameTextField() {
    _userNameObject.sink.add(null);
  }

  void resetPasswordTextField() {
    _passwordObject.sink.add(null);
  }

  void resetEmailTextField() {
    _emailObject.sink.add(null);
  }

  Future<bool> register(String username, String password, String email) async {
    validateUserName(username);
    validatePassword(password);
    validateEmail(email);
    if (validateEmail(email) && (validateUserName(username) && validatePassword(password))) {
      try {
        String id = await _firebaseReposity.signUp(email, password);
        if (!AppUtility.stringNullOrEmpty(id)) {
          return await _firebaseReposity.addUser(id, username, password, email);
        } else {
          return false;
        }
      } catch(e) {
        if (e is PlatformException) {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    String result;
    validateEmail(email);
    validatePassword(password);
    if (validateEmail(email) && validatePassword(password)) {
      result = await _firebaseReposity.signIn(email, password);
      if (result != null) {
        AppCaches.userId = result;
        AppCaches.setCacheUserId(result);
      }
      return !(result == null);
    } else {
      return false;
    }
  }

  Future<Account> getAccount(String userId) async {
    Account account = await _firebaseReposity.getCurrentUser(userId);
    return account;
  }

  getAccountCache() async {
    //Account account = await AppCaches.getAccount();
    String id = await AppCaches.getCacheUserId();
    //String id = account.id;
    if (!AppUtility.stringNullOrEmpty(id)) {
      Account account = await getAccount(id);
      AppCaches.currentAccount = account;
      AppCaches.isLogin = true;
      _accountObject.sink.add(account);
    } else {
      AppCaches.isLogin = false;
      _accountObject.sink.add(null);
    }
  }

  Future<bool> signout() async {
    return await _firebaseReposity.signOut();
  }

  void dispose() {
    _userNameObject.close();
    _emailObject.close();
    _passwordObject.close();
}

}