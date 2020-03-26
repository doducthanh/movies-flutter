import 'package:flutter/cupertino.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  BehaviorSubject<String> _userNameObject = BehaviorSubject<String>();
  get getUserNameStream => _userNameObject.stream;

  BehaviorSubject<String> _emailObject = BehaviorSubject<String>();
  get getEmailStream => _emailObject.stream;

  BehaviorSubject<String> _passwordObject = BehaviorSubject<String>();
  get getPasswordStream => _passwordObject.stream;

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

  void dispose() {
    _userNameObject.close();
    _emailObject.close();
    _passwordObject.close();
  }

  Future<bool> register(String username, String password, String email) async {
    validateUserName(username);
    validatePassword(password);
    validateEmail(email);
    if (validateEmail(email) && (validateUserName(username) && validatePassword(password))) {
      return await _firebaseReposity.addUser(username, password, email);
    } else {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    var result = false;
    validateUserName(username);
    validatePassword(password);
    if (validateUserName(username) && validatePassword(password)) {
      var listAccount = await _firebaseReposity.getAllAccount();
      listAccount.forEach((account) {
        if ((account.username == username) && (account.password == password)) {
          result = true;
        }
      });
      return result;
    } else {
      return false;
    }
  }
}