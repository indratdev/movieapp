import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/login_bloc/login_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/services/language_translation.dart';

import 'package:movie_app/shared/colors_app.dart';
import 'package:movie_app/shared/custom_dialog.dart';
import 'package:movie_app/views/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.sizeOf(context).height / 2.6,
          margin: const EdgeInsets.all(28),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey, width: 4)),
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoadingLoginUser) {
                CustomWidgets.showLoadingWidget(context);
              }
              if (state is FailureLoginUser) {
                //  Center( child: Text(state.info.toString()),);
                Navigator.pop(context);
                CustomWidgets().showMessageAlert(context, state.info.toString(),
                    StatusImage.failed, () => Navigator.pop(context));
              }

              if (state is SuccessLoginUser) {
                Navigator.pop(context);
                context.read<MovieBloc>()
                  ..add(GetRandomMovie())
                  ..add(GetMovieByTitle(title: "war"));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                    (route) => false);
              }
            },
            child: Column(
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.sizeOf(context).width / 12),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: LanguageTranslation.of(context)!.value('login'),
                      // prefixIcon: FaIcon(FontAwesomeIcons.mobileScreen),
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText:
                          LanguageTranslation.of(context)!.value('password'),
                      prefixIcon: Icon(Icons.password)),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 17,
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.blueMtix),
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginUser(
                          username: usernameController.text,
                          password: passwordController.text));
                    },
                    child: Text(
                      LanguageTranslation.of(context)!.value('login'),
                      style: TextStyle(
                          color: ColorsApp.backgroundDashboardColor,
                          fontSize: MediaQuery.sizeOf(context).width / 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
