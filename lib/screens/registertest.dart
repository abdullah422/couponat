import '../contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final authController = Get.find<AuthController>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hidePasswordConfirmation = true;
  Map<String, dynamic> registerData = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/registerr.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 87),
            child: const Text(
              "Create\nAccount",
              style: TextStyle(color: Colors.black, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.27),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: mainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      hintText: 'Name',
                      hintStyle: const TextStyle(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name field is required';
                      }
                    },
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: mainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email field is required';
                      }
                      else if(!value.contains('@')){
                        return 'Email formatting error ';
                      }
                    },
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: mainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(),

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {hidePassword = !hidePassword;
                          });
                        },
                        icon: hidePassword == true ? Icon(Icons.visibility_off,color: Color(0xff4c505b),) : Icon(Icons.visibility,color: Color(0xff4c505b),),
                      ),


                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password field is required';
                      }

                    },
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            print('gggggggg');
                            if (_formKey.currentState!.validate()) {
                              registerData['name'] = _nameController.text;
                              registerData['email'] = _emailController.text;
                              registerData['password'] = _passwordController.text;
                              authController.register(registerData: registerData);
                            }
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:mainColor,
                            child: Icon(Icons.arrow_forward,color:Colors.white)
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Color(0xff4c505b),
                            ),
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
