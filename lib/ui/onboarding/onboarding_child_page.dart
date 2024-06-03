import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ultils/enums/onboarding_page_position.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnboardingPagePosition onboardingPagePosition;
  final VoidCallback nextOnPressed;
  final VoidCallback backOnPressed;
  final VoidCallback skipOnPressed;
  const OnboardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.nextOnPressed,
      required this.backOnPressed,
      required this.skipOnPressed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSkipButton(),
                _buildOnboardingImage(),
                _buildOnboardingPageControl(),
                _buildOnboardingTitleAndContent(),
                _buildOnboardingNextAndBackButton()
              ],
            ),
          ),
        ));
  }

  Widget _buildSkipButton() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      alignment: AlignmentDirectional.centerStart,
      child: TextButton(
        onPressed: () {
          skipOnPressed.call();
        },
        child: Text(
          "SKIP",
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.44)),
        ),
      ),
    );
  }

  Widget _buildOnboardingImage() {
    return Image.asset(
      onboardingPagePosition.onboardingPageImage(),
      height: 296,
      width: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingPageControl() {
    // page 1 sáng ở vị tr 1 và xám 2 vị trí còn lại
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Vị trí 1
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page1
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
          // Vị trí 2
          Container(
            height: 4,
            width: 26,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page2
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
          // Vị trí 3
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page3
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            onboardingPagePosition.onboardingPageTitle(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontFamily: "Lato",
                fontSize: 32,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 42),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            onboardingPagePosition.onboardingPageContent(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildOnboardingNextAndBackButton() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                backOnPressed.call();
              },
              child: Text(
                "BACK",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                nextOnPressed.call();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                onboardingPagePosition == OnboardingPagePosition.page3
                    ? "GET STARTED"
                    : "NEXT",
                style: const TextStyle(
                    fontSize: 16, fontFamily: "Lato", color: Colors.white),
              ))
        ],
      ),
    );
  }
}
