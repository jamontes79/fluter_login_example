import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginexample/features/login/presentation/bloc/bloc.dart';
import 'package:loginexample/features/login/presentation/dto/login_dto.dart';
import 'package:loginexample/features/login/presentation/widgets/loading_widget.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String inputLogin;
  String inputPassword;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _bloc = serviceLocator<LoginBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Demo'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ErrorLoggedState) {
            final snackBar = SnackBar(content: Text('Invalid credentials...'));
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (state is LoggedState) {
            final snackBar = SnackBar(content: Text('User logged...'));
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
            if (state is InitialLoginState) {
              return _buildForm();
            } else if (state is CheckingLoginState) {
              return LoadingWidget();
            } else {
              return _buildForm();
            }
          },
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Placeholder(
              fallbackWidth: 150,
              fallbackHeight: 100,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the username',
                labelText: 'Username *',
              ),
              onChanged: (value) {
                inputLogin = value;
              },
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.isEmpty ? 'Username is mandatory' : null;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter the password',
                labelText: 'Password *',
              ),
              onChanged: (value) {
                inputPassword = value;
              },
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.isEmpty ? 'Password is mandatory' : null;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              color: Colors.black12,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final loginDTO = LoginDTO(
                    username: inputLogin,
                    password: inputPassword,
                  );
                  _bloc.add(CheckLoginEvent(login: loginDTO));
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
