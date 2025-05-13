import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/view/NavigationBar.dart';
import '../controller/Login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/img/logo.jpg'),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '10th World Congress of Coloproctology',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Row(

              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.calendar_month, color: Colors.grey),
                ),
                Text('April 3rd-6th, 2025'),
              ],
            ),
            const SizedBox(height: 5),
            Row(

              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.location_on, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    'Gokulam Park Convention Centre, Kochi, Kerala',
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {
                    return Obx(() => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SizedBox(
                        height: controller.isOtpSent.value
                            ? MediaQuery.of(context).size.height * 0.55
                            : MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('Assets/img/logo.jpg',height: 80,),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                controller.isOtpSent.value
                                    ? 'Enter OTP'
                                    : 'Sign in to your \nAccount',
                                style: const TextStyle(
                                    fontSize: 44),
                               // textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.isOtpSent.value
                                    ? 'An OTP has been sent to\n${controller.emailController.text}'
                                    : "Let's Sign in to your account an get started",
                               // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 25),

                              // --- Conditional UI for Email or OTP ---
                              if (!controller.isOtpSent.value)
                                TextFormField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  //autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              if (controller.isOtpSent.value)
                                TextFormField(
                                  controller: controller.otpController,
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  maxLength: 6,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18, letterSpacing: 3),
                                  decoration: InputDecoration(
                                    labelText: 'Enter OTP',
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 25),

                              // --- Loading Indicator or Button ---
                              controller.isLoading.value
                                  ? const Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                onPressed: controller.isLoading.value ? null : (
                                    controller.isOtpSent.value
                                        ? () async {
                                      // verifyOtpAndLogin will handle navigation
                                      await controller.verifyOtpAndLogin();
                                      // If successful, Get.offAll in controller
                                      // will close the modal and navigate.
                                      // If not, error message will show.
                                    }
                                        : controller.sendOtp // sendOtp will update isOtpSent
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.orange[700],
                                ),
                                child: Text(
                                  controller.isOtpSent.value
                                      ? 'Verify OTP & Sign In'
                                      : 'Send OTP',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // --- Error Message Display ---
                              if (controller.errorMessage.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.errorMessage.value!,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              // --- Option to change email if OTP is sent ---
                              if (controller.isOtpSent.value)
                                TextButton(
                                  onPressed: () {
                                    controller.isOtpSent.value = false;
                                    controller.errorMessage.value = null;
                                    controller.otpController.clear();
                                  },
                                  child: const Text("Change Email?"),
                                )
                            ],
                          ),
                        ),
                      ),
                    ));
                  },
                ).then((_) {

                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.orange[700],
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10), // Adjusted spacing
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top:16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            Center(child: Image.asset('Assets/img/logo.jpg', height: 40)),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Continue using Email and Mobile No',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.orange[700],
                                ),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Continue with Email and Mobile No',
                style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
              ),
            ),
            TextButton(
              onPressed: () {

                Get.to(() => CustomNavigationBar());
              },
              child: const Text(
                'Continue as Guest',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}