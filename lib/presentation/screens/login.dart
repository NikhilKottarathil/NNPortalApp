import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/presentation/components/clip_paths/background_clipper.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/basic_text_field.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nn_portal/main.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // TextEditingController emailTextEditingController = TextEditingController(text: 'rajeev');
  // TextEditingController passwordTextEditingController = TextEditingController(text: 'rajeev1234');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthenticationProvider>(context, listen: false)
        .attemptAutoLogin()
        .then((value) {
      if (!value) {
        FlutterNativeSplash.remove();
      } else {
        FlutterNativeSplash.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: AppColors.primaryBase,
          body: ListView(
            children: [
              SizedBox(
                height: height * .042,
              ),
              Image.asset('assets/app_logo.png',
                  height: width * .3 * (161 / 147), width: width * .3),
              SizedBox(
                height: height * .016,
              ),
              Align(
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: height * .6,
                      maxWidth: width - 60,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBase,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: height * .042,
                              ),
                              Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: AppColors.textLight),
                              ),
                              SizedBox(
                                height: height * .062,
                              ),
                              BasicTextField(
                                label: 'User name',
                                textEditingController:
                                    emailTextEditingController,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Enter User name'
                                      : null;
                                },
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: height * .042,
                              ),
                              BasicTextField(
                                  label: 'Password',
                                  textEditingController:
                                      passwordTextEditingController,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? 'Enter password'
                                        : null;
                                  },
                                  maxLength: 25,
                                  textInputType: TextInputType.visiblePassword),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Provider.of<AuthenticationProvider>(context,
                                        listen: false)
                                    .login(
                                        email: emailTextEditingController.text,
                                        password:
                                            passwordTextEditingController.text);
                              }
                            },
                            backgroundColor: AppColors.textLight,
                            child: Consumer<AuthenticationProvider>(
                                builder: (context, value, child) {
                              if (value.formStatus == FormStatus.loading) {
                                return const CustomCircularProgressIndicator();
                              }
                              return const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: TextButton(
              onPressed: () {
                Navigator.of(MyApp.navigatorKey.currentContext!)
                    .pushReplacementNamed('/home');
              },
              child: Text(
                'Continue as Quest',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
