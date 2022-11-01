import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_auth/email_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: Text('الخطوة 1'),
            content: Container(
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                20,
                                MediaQuery.of(context).size.height * 0.01,
                                20,
                                0),
                            child: Column(
                              children: <Widget>[
                                logoWidget("assets/images/forgot.png"),
                                Text("نسيت كلمة المرور؟",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25)),
                                Text(
                                    "الرجاء إدخال البريد الإلكتروني المرتبط بحسابك",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 129, 129, 129),
                                        fontSize: 17)),
                                const SizedBox(height: 50),
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      controller: email,
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.email_outlined,
                                            color: Color(0xFFFD8601)),
                                        labelText: "البريد الإلكتروني",
                                        hintText: "أدخل بريدك الإلكتروني",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            email.text.trim() == "") {
                                          return "الحقل مطلوب";
                                        } else if (!RegExp(
                                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                            .hasMatch(value)) {
                                          return 'أدخل بريد إلكتروني صالح';
                                        }
                                      },
                                    )),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      sendOTP();
                                    }
                                  },
                                  child: Text(" إرسال رمز التحقق",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(height: 20)
                              ],
                            )))))),
        Step(
            isActive: currentStep >= 1,
            title: Text("الخطوة 2"),
            content: Container(
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey2,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20,
                              MediaQuery.of(context).size.height * 0.01, 20, 0),
                          child: Column(
                            children: <Widget>[
                              logoWidget("assets/images/forgot.png"),
                              Text("نسيت كلمة المرور؟",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25)),
                              Text(
                                  "الرجاء إدخال رمز التحقق المرسل عبر بريدك الإلكتروني",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 129, 129, 129),
                                      fontSize: 17)),
                              const SizedBox(height: 50),
                              Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    controller: otp,
                                    decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.security_outlined,
                                          color: Color(0xFFFD8601)),
                                      labelText: " رمز التحقق",
                                      hintText: "أدخل رمز التحقق ",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          email.text.trim() == "") {
                                        return "الحقل مطلوب";
                                      }
                                    },
                                  )),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey2.currentState!.validate()) {
                                    verifyOTP();
                                  }
                                },
                                child: Text(" التحقق من رمز التحقق",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(height: 20)
                            ],
                          )))),
            )),
        Step(
          isActive: currentStep >= 2,
          title: Text("اعادة تعيين كلمة المرور"),
          content: Container(),
        ),
      ];

  void sendOTP() async {
    var emailauth = EmailAuth(sessionName: "إلفاء");
    if (await emailauth.sendOtp(recipientMail: email.text)) {
      Fluttertoast.showToast(
          msg: "تم إرسال رمز التحقق",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.lightGreen,
          fontSize: 16.0,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "حدث خطأ ما",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.red,
          fontSize: 16.0,
          textColor: Colors.white);
    }
  }

  void verifyOTP() {
    var emailauth = EmailAuth(sessionName: "إلفاء");
    if (emailauth.validateOtp(recipientMail: email.text, userOtp: otp.text)) {
      Fluttertoast.showToast(
          msg: "تم التحقق بنجاح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.lightGreen,
          fontSize: 16.0,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "رمز التحقق المدخل خاطئ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.red,
          fontSize: 16.0,
          textColor: Colors.white);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfafafa),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          title: const Text(
            "إعادة تعيين كلمة المرور",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          centerTitle: true,
        ),
        body: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: kOrangeColor)),
            child: Stepper(
              type: StepperType.horizontal,
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: controls.onStepCancel,
                      child: const Text(
                        'السابق',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton(
                      onPressed: controls.onStepContinue,
                      child: const Text('التالي',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w800)),
                    ),
                  ],
                );
              },
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  print("Completed");
                }
                setState(() => currentStep += 1);
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              //  controlsBuilder:
            )));
  }

  Widget logoWidget(String imageName) {
    return Center(
        child: Image.asset(
      imageName,
      fit: BoxFit.fill,
      width: 150,
      height: 150,
    ));
  }
}
