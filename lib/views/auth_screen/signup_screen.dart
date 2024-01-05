import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // this is for the check box of terms and conditions
  bool? isCheck = false;

  // for the backed
  var controller = Get.put(AuthController());

  // creating the text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  //end of backend

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            // This is the title below app icon
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                // 1st textfiel for the signup name
                customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false),
                // 2nd textfield for the signup email
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false),
                // 3rd textfield for the signup password
                customTextField(
                    hint: passwrodHint,
                    title: password,
                    controller: passwordController,
                    isPass: true),
                // 4th textfield for the retype signup password
                customTextField(
                    hint: passwrodHint,
                    title: retypePassword,
                    controller: passwordRetypeController,
                    isPass: true),

                // creatig the forget button
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                5.heightBox,

                Row(
                  children: [
                    Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: termAndCond,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ))
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                // Creating the Signup button
                ourButton(
                  color: isCheck == true ? redColor : lightGrey,
                  title: sigup,
                  textColor: whiteColor,
                  onPress: () async {
                    if (isCheck != false) {
                      try {
                        await controller
                            .signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          return controller.storeUserData(
                              name: nameController.text,
                              password: passwordController.text,
                              email: emailController
                                  .text); // passing the values for the storedata fuction in auth_controller
                        }).then((value) {
                          VxToast.show(context, msg: loggedIn);
                          Get.offAll(() => const Home());
                        });
                      } catch (e) {
                        auth.signOut();
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: e.toString());
                      }
                    }
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                // wrapping into gesture detector of velocity X
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    })
                  ],
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ]),
        ),
      ),
    ));
  }
}
