import 'package:aerocode/screens/space/space.dart';
import 'package:aerocode/utils/snackbar.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '/controllers/backend_controller.dart';
import '/controllers/space_controller.dart';
import '/controllers/code_controller.dart';

import 'package:aerocode/utils/colors.dart';

final firestore = FirebaseFirestore.instance;

final _backendCtr = Get.put(backendController());
final _spaceCtr = Get.put(spaceController());
final _codeCtr = Get.put(codeController());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Title(
          title: 'Aerocode',
          color: Colors.black,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Builder(
              builder: (context) {
                if(constraints.maxWidth > 768) {
                  double _displayTextSize = MediaQuery.of(context).size.width*0.022*0.8;
                  double _logoSize = MediaQuery.of(context).size.width*0.07;
                  double _iconGaps = MediaQuery.of(context).size.width*0.01;
                  return Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(60.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width*0.8,
                                  child: Center(
                                    child: Text(
                                      "{aerocode}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: _logoSize,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox( height: 35,),
                                Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width*0.8,
                                  child: Center(
                                    child: Text(
                                      "Share code over the internet without signing in!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _displayTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: primaryPurple,
                                  shadowColor: darkPurple,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Ionicons.logo_linkedin, color: Colors.white, size: _displayTextSize,),
                                        SizedBox(width: _iconGaps-5,),
                                        InkWell(
                                          child: Text(
                                            "@shxntanu", 
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: _displayTextSize,
                                            ),
                                          ),
                                          onTap: () => launchUrl(Uri(
                                            scheme: 'https',
                                            host: 'www.linkedin.com',
                                            path: '/in/shxntanu',
                                          )),
                                        ),
                                        SizedBox(width: _iconGaps,),
                                        Icon(Ionicons.logo_github, color: Colors.white, size: _displayTextSize,),
                                        SizedBox(width: _iconGaps-5,),
                                        InkWell(
                                          child: Text(
                                            "/shxntanu", 
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: _displayTextSize,
                                            ),
                                          ),
                                          onTap: () => launchUrl(Uri(
                                            scheme: 'https',
                                            host: 'www.github.com',
                                            path: '/shxntanu',
                                          )),
                                        ),
                                      ],
                                    )
                                    ),
                                  ),
                              ],
                            ),
                          )
                      ),
                      Expanded(
                          child: Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                joinForm(width: MediaQuery.of(context).size.width*0.4,),
                                              
                                const SizedBox(
                                  height: 70.0,
                                ),
                                              
                                createForm(width: MediaQuery.of(context).size.width*0.4,),
                              ],
                            ),
                          )
                      ),
                    ],
                  );
                }

                else {
                  return Center(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width*0.8,
                            height: MediaQuery.of(context).size.height*0.2,
                            child: Center(
                              child: Text(
                                "{aerocode}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height*0.05,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.black,
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  joinForm(gap: 5, width: MediaQuery.of(context).size.width,),
                                                
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                                
                                  createForm(gap: 5,width: MediaQuery.of(context).size.width,),

                                  const SizedBox(
                                    height: 20.0,
                                  ),

                                  Card(
                                  color: primaryPurple,
                                  shadowColor: darkPurple,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                          Row(
                                            children: [
                                              const Icon(Ionicons.logo_linkedin, color: Colors.white, size: 20.0,),
                                              const SizedBox(width: 10.0,),
                                              InkWell(
                                                child: const Text(
                                                  "@shxntanu", 
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                onTap: () => launchUrl(Uri(
                                                  scheme: 'https',
                                                  host: 'www.linkedin.com',
                                                  path: '/in/shxntanu',
                                                )),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              const Icon(Ionicons.logo_github, color: Colors.white, size: 20.0,),
                                              const SizedBox(width: 10.0,),
                                              InkWell(
                                                child: const Text(
                                                  "/shxntanu", 
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                onTap: () => launchUrl(Uri(
                                                  scheme: 'https',
                                                  host: 'www.github.com',
                                                  path: '/shxntanu',
                                                )),
                                              ),
                                            ],
                                          ),
                                      ],
                                    )
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class joinForm extends StatefulWidget {

  joinForm({this.gap = 20, this.width});

  final gap;
  final width;

  @override
  State<joinForm> createState() => _joinFormState();
}

class _joinFormState extends State<joinForm> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  onJoinPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _backendCtr.joinSpaceInst(_usernameController.text, _passwordController.text).then((value) async {
          if(value == false) {
            showSnackbar(context, "Wrong username or password");
          }
          if(value == "No such space has been created") {
            showSnackbar(context, "No such space has been created");
          }
          if(value == true) {
            final code = await _codeCtr.getCode(spaceID: _usernameController.text);
            if(await _backendCtr.joinSpaceInst(_usernameController.text, _passwordController.text)) {
              Get.offAll(Space(spaceID: _usernameController.text, code: code,));
            }
          }
        }
        );
      }
      catch (e) {
        showSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Join a space',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: widget.width,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _usernameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  maxLength: 500,
                  decoration: const InputDecoration(
                    hintText: 'SpaceID',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: darkPurple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: primaryPurple,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: widget.gap,
                ),

                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                        icon: (_obscureText)
                            ? const Icon(Icons.visibility_off, color: Colors.white,)
                            : const Icon(Icons.visibility, color: Colors.white,),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: darkPurple,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: primaryPurple,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 20.0,
        ),

        SizedBox(
          width: 90.0,
          height: 40.0,
          child: ElevatedButton(
            onPressed: onJoinPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primaryPurple,
            ),
            child: const Text('Join',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),),
          ),
        ),
      ],
    );
  }
}

class createForm extends StatefulWidget {
  
  createForm({this.gap = 20, this.width});

  final gap;
  final width;

  @override
  State<createForm> createState() => _createFormState();
}

class _createFormState extends State<createForm> {

  final _spaceID = randomNumeric(6);
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Create a space',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: widget.width,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  readOnly: true,
                  initialValue: _spaceID,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    hintText: 'SpaceID',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: darkPurple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: primaryPurple,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: widget.gap,
                ),

                TextFormField(
                  validator: (value) {
                    
                  },
                  controller: _passwordController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: darkPurple,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                        icon: (_obscureText)
                            ? const Icon(Icons.visibility_off, color: Colors.white,)
                            : const Icon(Icons.visibility, color: Colors.white,),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: primaryPurple,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 90.0,
          height: 40.0,
          child: ElevatedButton(
            onPressed: () async {

              final pass = _passwordController.text;
              if (pass.isEmpty) {
                showSnackbar(context, 'Please enter a password', kDuration: const Duration(seconds: 1));
              }
              else if (pass.length < 8) {
                showSnackbar(context, 'Password must be at least 8 characters', kDuration: const Duration(seconds: 1));
              }
              else if(pass.contains(" ")) {
                showSnackbar(context, 'Password cannot contain spaces', kDuration: const Duration(seconds: 1));
              }
              else {
                await _backendCtr.createSpaceInst(_spaceID, _passwordController.text);
                await _codeCtr.createCode(spaceID: _spaceID);
                Get.offAll(Space(spaceID: _spaceID, code: "// Start typing from here...",));
              }

            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primaryPurple,
            ),
            child: const Text('Create',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),),
          ),
        ),
      ],
    );
  }
}
