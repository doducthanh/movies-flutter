import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterappmovie/bloc/login_bloc.dart';
import 'package:flutterappmovie/common/image_path_const.dart';
import 'package:flutterappmovie/screen/login/login_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _registerBloc = LoginBloc();
  var _usernameController = TextEditingController();
  var _passController = TextEditingController();
  var _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
        leading: FlatButton(
          child: IconButton(icon: Icon(Icons.arrow_back_ios),),
          onPressed: (){
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
      body: ProgressHUD(child: Builder(builder: (context) => Container(child: _buildBodyWidget(context)))),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode curren = FocusScope.of(context);
        if (!curren.hasPrimaryFocus) {
          curren.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Image(image: AssetImage(ImagePathConst.imgLogo),height: 250, fit: BoxFit.fitWidth,),
              _buildUserNameForm(),
              SizedBox(height: 16),
              _buildPassForm(),
              SizedBox(height: 16,),
              _buildEmailForm(),
              SizedBox(height: 16,),
              _buildButtonRegister(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameForm() {
    return
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: StreamBuilder<String>(
          stream: _registerBloc.getUserNameStream,
          builder: (context, snapshot) {
            var textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              controller: _usernameController,
              onTap: _registerBloc.resetUsernameTextField,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                errorText: textError
              ),

            );
          }
        ),
      );
  }

  Widget _buildPassForm() {
    return
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: StreamBuilder<String>(
          stream: _registerBloc.getPasswordStream,
          builder: (context, snapshot) {
            var textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              controller: _passController,
              onTap: _registerBloc.resetPasswordTextField,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                errorText: textError,
              ),
            );
          }
        ),
      );
  }

  Widget _buildEmailForm() {
    return
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: StreamBuilder<String>(
          stream: _registerBloc.getEmailStream,
          builder: (context, snapshot) {
            var textError = (snapshot.hasData) ? snapshot.data : null;
            return TextField(
              controller: _emailController,
              onTap: _registerBloc.resetEmailTextField,
              cursorRadius: Radius.circular(12),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                errorText: textError,
              ),

            );
          }
        ),
      );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
      child: RaisedButton(
        color: Colors.lightBlue,
        disabledColor: Colors.lightBlue,
        child: Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 16),),
        onPressed: ()async{
          final hub = ProgressHUD.of(context);
          hub.show();
          bool result = await _registerBloc.register(
              _usernameController.text,
              _passController.text,
              _emailController.text);
          if (result) {
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage(username: _usernameController.text)));
          } else {
            hub.dismiss();
          }
        },
      ),
    );
  }



}
