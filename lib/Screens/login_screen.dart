import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:antoh/provider/UserProvider.dart';
import 'package:antoh/screens/homepage.dart';
import 'package:antoh/screens/registration_screen.dart';
import 'package:antoh/utils/InputValidator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).initFirebase();
    });
  }

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _userLogin = {
    'email': null,
    'password': null,
  };
  bool isLoading = false;

  void _submitForm(Function login) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> successInformation = await login(_userLogin);
    if (successInformation['success']) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              headerAnimationLoop: true,
              title: 'SUCCESS',
              desc: successInformation['message'])
          .show();
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              headerAnimationLoop: true,
              title: 'Error',
              desc: successInformation['message'])
          .show();
    }
    setState(() {
      isLoading = false;
    });
  }

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    //email field
    final emailField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: InputValidator.email,
        onSaved: (input) {
          _userLogin['email'] = input;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(
              Icons.mail,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    final passwordField = TextFormField(
      //password field
      autofocus: false,
      validator: InputValidator.password,
      onSaved: (input) {
        _userLogin['password'] = input;
      },
      textInputAction: TextInputAction.done,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
        prefixIcon:  Icon(Icons.vpn_key,color: Theme.of(context).primaryColor,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          _submitForm(userProvider.Login);
        },
        child: const Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          
                          Text('Antohs',style: TextStyle(

                            fontSize: 50,
                            fontWeight: FontWeight.bold
                          ),),

                          // SizedBox(
                          //     height: 100,
                          //     child: Image.asset(
                          //       "assets/images/logo.png",
                          //       fit: BoxFit.contain,
                          //     )),
                          const SizedBox(
                            height: 45,
                          ),
                          emailField,
                          const SizedBox(
                            height: 20,
                          ),
                          passwordField,
                          const SizedBox(
                            height: 30,
                          ),
                          loginButton,
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // GestureDetector(
                              // child: Image.asset(
                              //   "assets/images/facebook.png",
                              //   width: 200,
                              // ),
                              // onTap: () {
                              // }),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                              child: Image.asset(
                                "assets/images/google.png",
                                width: 206,
                              ),
                              onTap: ()  {
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Don't have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
