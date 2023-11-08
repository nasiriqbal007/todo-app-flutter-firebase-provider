import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Models/onboarding_model.dart';
import 'package:todo_app/Routes/routes.dart';
import 'package:todo_app/Utils/user_status.dart';
import 'package:todo_app/Widgets/customButtons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  // ignore: unused_field
  int _currentIndex = 0;
  UserStatusChecker userStatusChecker = UserStatusChecker();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page == onboardingData.length - 1) {
        userStatusChecker.setFirstTimeUser();
        Get.offNamed(AppRoutes.loginScreen);
      }
      setState(() {
        _currentIndex = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, bottom: 100, left: 300),
                child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: Center(
                      child: CustomIconButton(
                          icon: Icons.close,
                          iconSize: 12,
                          onPressed: () {
                            Get.toNamed(AppRoutes.loginScreen);
                          }),
                    )),
              ),
              SizedBox(
                height: 400,
                child: PageView.builder(
                    physics: const ScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _currentIndex = value;
                      });
                    },
                    controller: _controller,
                    itemCount: onboardingData.length,
                    itemBuilder: ((context, index) {
                      ObModel model = onboardingData[index];
                      return Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(model.image),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              model.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              model.description,
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    })),
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: const WormEffect(
                    activeDotColor: Colors.black,
                    dotHeight: 10,
                    dotWidth: 10,
                    type: WormType.thinUnderground,
                    paintStyle: PaintingStyle.stroke),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
