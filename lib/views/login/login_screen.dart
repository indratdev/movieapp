import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/bloc/login_bloc.dart';
import 'package:movie_app/shared/colors_app.dart';
import 'package:movie_app/shared/custom_dialog.dart';

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
          height: MediaQuery.sizeOf(context).height/2.6,
        margin: EdgeInsets.all(28),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey, width:4)),
              constraints: BoxConstraints(
            maxWidth: 400, // Adjust the width as needed
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is LoadingLoginUser){
                // showDialog(context: context, builder: (context) => Center( child: const CircularProgressIndicator.adaptive(),));
                 CustomWidgets.showLoadingWidget(context);
              }
               if(state is FailureLoginUser){
                //  Center( child: Text(state.info.toString()),);
                Navigator.pop(context);
                CustomWidgets().showMessageAlert(context, state.info.toString(), StatusImage.failed, () => Navigator.pop(context));
              }
        
              if(state is SuccessLoginUser){
                Navigator.pop(context);
                print("Sukses");
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
                      hintText: "Username",
                      // prefixIcon: FaIcon(FontAwesomeIcons.mobileScreen),
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: "password",
                      // prefixIcon: FaIcon(FontAwesomeIcons.lock),
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
                      "Log In",
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
