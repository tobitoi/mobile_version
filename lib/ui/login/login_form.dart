import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/login/login.dart';
import 'package:mobile_version/ui/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/icons/favicon.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);

    _onLoginButtonPressed() {
      if (_usernameController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Username must not be blank'), Icon(Icons.error)],
            ),
            backgroundColor: Colors.red));
      } else if (!(_usernameController.text.length >= 3) &&
          _usernameController.text.isNotEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Username should contains more then 3 character'),
                Icon(Icons.error)
              ],
            ),
            backgroundColor: Colors.red));
      } else if (_passwordController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Password must not be blank'), Icon(Icons.error)],
            ),
            backgroundColor: Colors.red));
      } else if (!(_passwordController.text.length >= 6) &&
          _passwordController.text.isNotEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Password should contains more then 6 character'),
              Icon(Icons.error)
            ],
          ),
          backgroundColor: Colors.red,
        ));
      } else {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
          ),
        );
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          var unreachable = state.error.substring(33);
          if (unreachable.contains(
              "SocketException: Connection failed (OS Error: Network is unreachable, errno = 101), address = 202.152.38.77, port = 443")) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Network is unreachable'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${state.error.substring(33)}'),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red),
            );
          }
        }
        if (state is LoginLoading) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
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
                FadeAnimation(
                    1.2,
                    SizedBox(
                      height: 230,
                      child:
                          Container(padding: EdgeInsets.all(50), child: image),
                    )),
                Form(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _userNameField(),
                      _passwordField(),
                      FadeAnimation(
                          1.8,
                          Container(
                              padding: EdgeInsets.all(10),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                onPressed: state is! LoginLoading
                                    ? _onLoginButtonPressed
                                    : null,
                                child: Text('Login',
                                    style: TextStyle(fontSize: 16)),
                                color: Colors.blue,
                              ))),
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userNameField() {
    return FadeAnimation(
        1.5,
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'username',
              icon: Icon(Icons.perm_identity),
            ),
          ),
        ));
  }

  Widget _passwordField() {
    return FadeAnimation(
        1.5,
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: 'Password',
              
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'show password' : 'hide password',
                ),
              ),
            ),
          ),
        ));
  }
}
