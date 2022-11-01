import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elfaa/screens/login/login_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController nnew = TextEditingController();
  TextEditingController confirmed = TextEditingController();
  String? _new;
  String? _confirmed;
  bool pass2 = true;
  bool pass3 = true;
  Icon icon2 = Icon(Icons.visibility, color: Colors.grey);
  Icon icon3 = Icon(Icons.visibility, color: Colors.grey);

  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  Widget _buildNew() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextFormField(
              textAlign: TextAlign.right,
              obscureText: pass2,
              controller: nnew,
              decoration: InputDecoration(
                  labelText: 'كلمة المرور الجديدة',
                  hintText: 'أدخل كلمة مرور جديدة',
                  helperText: "",
                  suffixIcon: IconButton(
                    icon: icon2,
                    onPressed: () {
                      setState(() {
                        pass2 = !pass2;
                        if (pass2 == true) {
                          icon2 = Icon(Icons.visibility, color: Colors.grey);
                        } else {
                          icon2 =
                              Icon(Icons.visibility_off, color: Colors.grey);
                        }
                      });
                    },
                  )),
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (String? value) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])'); //Min 1 uppercase, 1 lowercase and 1 numeric number
                if (value!.isEmpty || nnew.text.trim() == "") {
                  return "الحقل مطلوب";
                } else if (!regex.hasMatch(value)) {
                  return "كلمة المرور يجب أن تحتوي على حرف كبير، حرف صغير، ورقم";
                } else if (value.length < 8) {
                  return "ادخل كلمة مرور مكوّنة من 8 خانات على الأقل";
                }
                return null;
              },
              onSaved: (String? value) {
                _new = value;
              },
            )));
  }

  Widget _buildConfirmed() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextFormField(
              textAlign: TextAlign.right,
              obscureText: pass3,
              controller: confirmed,
              decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور الجديدة',
                  hintText: 'أعد إدخال كلمة المرور الجديدة',
                  helperText: "",
                  suffixIcon: IconButton(
                    icon: icon3,
                    onPressed: () {
                      setState(() {
                        pass3 = !pass3;
                        if (pass3 == true) {
                          icon3 = Icon(Icons.visibility, color: Colors.grey);
                        } else {
                          icon3 =
                              Icon(Icons.visibility_off, color: Colors.grey);
                        }
                      });
                    },
                  )),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'الحقل مطلوب';
                }
                return null;
              },
              onSaved: (String? value) {
                _confirmed = value;
              },
            )));
  }


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
                                            Color(0xFF818181),
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
          title: Text("إعادة تعيين كلمة المرور"),
          content: Container(
            margin: EdgeInsets.fromLTRB(24, 24, 24, 100),
            child: Form(
              key: _formKey3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  _buildNew(),
                  _buildConfirmed(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey3.currentState!.validate()) {
                        _formKey3.currentState!.save();
                      }
                    },
                    child: Text(" إعادة تعيين",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
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

  bool verifyOTP() {
    bool succ = false;
    var emailauth = EmailAuth(sessionName: "إلفاء");
    if (emailauth.validateOtp(recipientMail: email.text, userOtp: otp.text)) {
      succ = true;
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
    return succ;
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
                if (currentStep == 0 || email.value.text.isNotEmpty)
                  setState(() => currentStep += 1);
                else if (currentStep == 1 || verifyOTP())
                  setState(() => currentStep += 1);
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
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
