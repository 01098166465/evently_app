import 'package:flutter/material.dart';
import '../../auth/login_screen.dart';
import '../../app_theme.dart';
import 'intro_page_item.dart';
import 'intro_data.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = "/intro";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: introPages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return IntroPageItem(
                    pageData: introPages[index],
                    textTheme: textTheme,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex != 0
                      ? buildNavButton(
                          icon: Icons.arrow_back,
                          onTap: () {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        )
                      : SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      introPages.length,
                      (index) => Container(
                        margin: EdgeInsets.all(4),
                        width: currentIndex == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? AppTheme.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  buildNavButton(
                    icon: currentIndex == introPages.length - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                    onTap: () {
                      if (currentIndex == introPages.length - 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildNavButton({required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: AppTheme.primary),
      style: IconButton.styleFrom(
        backgroundColor: AppTheme.backgroundLight,
        side: BorderSide(color: AppTheme.primary),
        shape: CircleBorder(),
        fixedSize: Size(30, 30),
      ),
    );
  }
}
