import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// 홈 화면을 StatefulWidget 클래스로 구현합니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // 상태를 관리하는 State 객체를 생성합니다.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 홈 화면을 관리하는 State 클래스를 생성합니다.
class _HomeScreenState extends State<HomeScreen> {
  // 페이지 컨트롤러를 생성합니다.
  final PageController pageController = PageController();

  @override
  // State 객체가 처음 생성될 때 호출되는 initState() 함수입니다.
  void initState() {
    super.initState();

    // 10초마다 페이지를 자동 전환하도록 타이머를 설정합니다.
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        int? nextPage = pageController.page?.toInt(); // 다음 페이지 번호를 계산합니다.

        if (nextPage == null) {
          return;
        }

        if (nextPage == 4) {
          // 마지막 페이지에 도달하면 첫 페이지로 되돌아갑니다.
          nextPage = 0;
        } else {
          nextPage++;
        }

        // 페이지를 스무스하게 전환합니다.
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  // 홈 화면을 구성하는 UI를 생성합니다.
  Widget build(BuildContext context) {
    // 안드로이드 시스템 UI의 색을 라이트 테마로 변경합니다.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // 페이지뷰를 생성하고, 각 페이지에 이미지 위젯을 표시합니다.
    return Scaffold(
      body: PageView(
        // 페이지뷰를 제어하기 위해 컨트롤러를 설정합니다.
        controller: pageController,

        // 페이지에 표시할 위젯 목록을 설정합니다.
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/img/image_$number.jpg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
