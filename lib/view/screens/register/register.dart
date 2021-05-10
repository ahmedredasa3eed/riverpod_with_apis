
import 'dart:io';
import 'package:dounts/enums/enums.dart';
import 'package:dounts/providers/auth_providers.dart';
import 'package:dounts/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/custom_button.dart';
import 'common/custom_text_field.dart';
import 'common/select_image.dart';

class RegisterView extends StatefulWidget {
  static const routeName = 'register-view';

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  File _selectedImageFile;
  void _onSelectedImage(File pickedImage){
    _selectedImageFile = pickedImage;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize:  MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Register",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 32),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  isSecure: false,
                                  hintText: "name",
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  needSuffixIcon: false,
                                  isReadOnly: false,
                                ),
                                SizedBox(height: 12),
                                CustomTextField(
                                  isSecure: false,
                                  hintText: "phone",
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  needSuffixIcon: false,
                                  isReadOnly: false,
                                ),
                                SizedBox(height: 12),
                                CustomTextField(
                                  isSecure: false,
                                  hintText: "email",
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  needSuffixIcon: false,
                                  isReadOnly: false,
                                ),
                                SizedBox(height: 12),
                                CustomTextField(
                                  isSecure: true,
                                  hintText: "password",
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  needSuffixIcon: false,
                                  isReadOnly: false,
                                ),
                                SizedBox(height: 32),
                                ImageInput(_onSelectedImage),
                                SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

                SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30,horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: (watch(userRegisterStatus).state == RegisterStatus.Loading)
                              ? Center(child: CircularProgressIndicator(),)
                              : CustomButton(
                            buttonText: "Register",
                            onTap: () async {
                              await RegisterViewModel().trySignUp(_nameController.text, _phoneController.text, _emailController.text, _passwordController.text, _selectedImageFile, context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
