import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterappmovie/bloc/account_bloc.dart';
import 'package:flutterappmovie/const/cache.dart';
import 'package:flutterappmovie/const/colors.dart';
import 'package:flutterappmovie/const/image.dart';
import 'package:flutterappmovie/screen/login/register_screen.dart';
import 'package:flutterappmovie/screen/tab/main_screen.dart';
import 'package:flutterappmovie/utility/app_utility.dart';

class LoginPage extends StatefulWidget {
  //Function loginCallback;

  LoginPage({Key key})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountBloc _accountBloc = AccountBloc();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var isLoading = false;
  var focusNode = FocusNode();
  var isHidePass = true;

  @override
  void initState() {
    super.initState();
  }

  actionLogin(BuildContext context) async {
    ProgressHUD.of(context).show();
    if (await _accountBloc.login(
        _usernameController.text, _passwordController.text)) {
      print("ddthanh: dang nhap thanh cong");
      ProgressHUD.of(context).dismiss();
      AppCaches.isLogin = true;
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => MainPage()));
    } else {
      ProgressHUD.of(context).dismiss();
      print("ddthanh: dang nhap that bai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MAIN_THEME,
        title: Text('Đăng nhập'),
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, CupertinoPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),

      body: ProgressHUD(child: Builder(builder: (context) => Container(child: _buildBodyWidget(context)))),

    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode curren = FocusScope.of(context);
        if (!curren.hasPrimaryFocus) {
          curren.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(ImagePath.imgLogo),
                height: 250,
                fit: BoxFit.fitWidth,
              ),
              _buildUserNameForm(),
              SizedBox(height: 16),
              _buildPassForm(),
              _buildButtonLogin(context),
              _buildButtonRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameForm() {
    String textError = null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: StreamBuilder<String>(
          stream: _accountBloc.getEmailStream,
          builder: (context, snapshot) {
            textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              onTap: _accountBloc.resetUsernameTextField,
              controller: _usernameController,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                errorText: textError,
              ),
            );
          }),
    );
  }

  Widget _buildPassForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: StreamBuilder<String>(
          stream: _accountBloc.getPasswordStream,
          builder: (context, snapshot) {
            var textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              obscureText: isHidePass,
              onTap: _accountBloc.resetPasswordTextField,
              controller: _passwordController,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        isHidePass = !isHidePass;
                      });
                    },
                    iconSize: 24,
                    icon: isHidePass ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  errorText: textError),
            );
          }),
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: RaisedButton(
        color: Colors.lightBlue,
        disabledColor: Colors.lightBlue,
        child: Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: ()async {
          ProgressHUD.of(context).show();
          var result = await _accountBloc.login(
              _usernameController.text, _passwordController.text);
          if (result) {
            print("ddthanh: dang nhap thanh cong");
            ProgressHUD.of(context).dismiss();

            AppCaches.currentAccount = await _accountBloc.getAccount(AppCaches.userId);
            AppCaches.setCacheUserId(AppCaches.userId);
            AppCaches.cacheAccount(AppCaches.currentAccount);
            AppCaches.isLogin = true;

            Navigator.push(context,MaterialPageRoute(builder: (context) => MainPage()));
          } else {
            ProgressHUD.of(context).dismiss();
            print("ddthanh: dang nhap that bai");
          }
        },
      ),
    );
  }

  Widget _buildButtonRegister() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: FlatButton(
        color: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledColor: Colors.transparent,
        child: Text(
          'Bạn chưa có tài khoản? Đăng ký',
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => (RegisterPage())));
        },
      ),
    );
  }

  _navigatorRegister() async {
    String result = await Navigator.push(context,
      CupertinoPageRoute(builder: (context) => (RegisterPage()))
    );
    if (AppUtility.stringNullOrEmpty(result)) {
      setState(() {
        _usernameController.text = result;
      });

    }
  }
}
