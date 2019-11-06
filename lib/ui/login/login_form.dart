import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/login/login.dart';

class LoginForm extends StatefulWidget {
  
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/icons/favicon.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                
                Form(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                    children: [
                      _userNameField(),
                      _passwordField(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 160.0),
                          shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0) ),
                          onPressed:
                                state is! LoginLoading ? _onLoginButtonPressed : null,
                          child: Text('Login', style: TextStyle(fontSize: 16)),
                          color: Colors.blue,
                        )
                      ),
                      Container(
                        child: state is LoginLoading
                          ? CircularProgressIndicator()
                          : null,
                      )
                    ],
                  ),
                  ) 
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userNameField(){
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _usernameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'username',
          border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0)
                  ) 
        ),
      ),
    );
  }

  Widget _passwordField(){
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0)
                  ) 
        ),
      ),
    );
  }
}