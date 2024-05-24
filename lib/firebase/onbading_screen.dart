import 'package:firebase_mxpert/screens/login.dart';
import 'package:flutter/material.dart';

import '../screens/login_phone.dart';
import '../utils/constant.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> images = [
    'assets/images/pana.png',
    'assets/images/online shopping.png',
    'assets/images/new.png',
  ];
  List<String> text = [
    'ONLINE SHOPPING',
    'ONLINE SERVICES',
    'HOME DELIVERY SERVICES',
  ];

  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentIndex < images.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LogPhone(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(images[index]);
              },
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      text[_currentIndex],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra quam elementum massa, viverra. Ut turpis consectetur. ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 80,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogPhone(),
                                ),
                              );
                            },
                            child: Text(
                              'Skip >> ',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            )),
                        InkWell(
                            onTap: _onNextPressed,
                            child: Image.asset(
                              "assets/images/next-arrow@3x.png",
                              height: 100,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
