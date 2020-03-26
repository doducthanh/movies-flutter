import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterappmovie/bloc/login_bloc.dart';
import 'package:flutterappmovie/common/cache.dart';
import 'package:flutterappmovie/common/image_path_const.dart';
import 'package:flutterappmovie/screen/login/register_screen.dart';
import 'package:flutterappmovie/screen/main_screen.dart';

class LoginPage extends StatefulWidget {
  String username;

  LoginPage({Key key, this.username = ""}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _loginBloc = LoginBloc();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var isLoading = false;
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    setState(() {
      _usernameController.text = widget.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),
      body: ProgressHUD(child: Builder(
        builder: (context) => Container(child:_buildBodyWidget(context))),
      ) ,
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
                image: AssetImage(ImagePathConst.imgLogo),
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
          stream: _loginBloc.getUserNameStream,
          builder: (context, snapshot) {
            textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              onTap: _loginBloc.resetUsernameTextField,
              controller: _usernameController,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                hintText: 'Username',
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
          stream: _loginBloc.getPasswordStream,
          builder: (context, snapshot) {
            var textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              onTap: _loginBloc.resetPasswordTextField,
              controller: _passwordController,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
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
        onPressed: () async {
          final hub = ProgressHUD.of(context);
          hub.show();
          if (await _loginBloc.login(
              _usernameController.text, _passwordController.text)) {
            print("ddthanh: dang nhap thanh cong");
            AppCaches.isLogin = true;
            Navigator.pop(context);
          } else {
            hub.dismiss();
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
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => (RegisterPage())));
        },
      ),
    );
  }
}
