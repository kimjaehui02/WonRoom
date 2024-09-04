import 'package:flutter/material.dart';
import 'package:wonroom/Splash/splash_functions.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart';
// import 'splash_functions.dart'; // navigateToJoin 함수를 불러옵니다

class Splash extends StatefulWidget {
  final Widget? data2; // 전달받을 데이터

  const Splash({Key? key, this.data2}) : super(key: key);

  // const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  //


  @override
  void initState() {
    super.initState();

    // 애니메이션이 끝난 후 페이지 전환
    if(widget.data2 != null)
    {
      print("asdasdasdas");
      print("asdasdasdas");
      print("asdasdasdas");
      print("asdasdasdas");

      // 애니메이션 컨트롤러 초기화
      _controller = AnimationController(
        duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간
        vsync: this,
      );

      // 로고 애니메이션 정의 (페이드 인 효과)
      _logoAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      );

      // 텍스트 애니메이션 정의 (페이드 인 효과)
      _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.5, 1.0, curve: Curves.easeIn),
        ),
      );

      // 애니메이션 시작
      _controller.forward();

      navigateToJoin(context, widget.data2 ?? Intro(), duration: 1); // 3초 후 화면 이동


    }
    else
    {
      print("???????");
      print("???????");
      print("???????");
      print("???????");

      // 애니메이션 컨트롤러 초기화
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), // 애니메이션 지속 시간
        vsync: this,
      );

      // 로고 애니메이션 정의 (페이드 인 효과)
      _logoAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      );

      // 텍스트 애니메이션 정의 (페이드 인 효과)
      _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.5, 1.0, curve: Curves.easeIn),
        ),
      );

      // 애니메이션 시작
      _controller.forward();

      navigateToJoin(context, Intro(), duration: 3); // 3초 후 화면 이동

    }





  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 최소한의 높이로 설정
                  children: [
                    // 로고 애니메이션 적용
                    FadeTransition(
                      opacity: _logoAnimation,
                      child: Image.asset(
                        'images/스플래시2.png', // 이미지 경로
                        height: 110, // 이미지의 높이 조정
                        width: 110, // 이미지의 너비 조정
                      ),
                    ),
                    SizedBox(height: 10), // 이미지와 텍스트 사이의 공간
                    // 텍스트 애니메이션 적용
                    FadeTransition(
                      opacity: _textAnimation,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Won', // 초록색으로 할 부분
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSerifDisplay',
                                letterSpacing: 2,
                                fontSize: 42,
                              ),
                            ),
                            TextSpan(
                              text: '-Room', // 나머지 부분
                              style: TextStyle(
                                color: Color(0xff595959),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DMSerifDisplay',
                                letterSpacing: 1,
                                fontSize: 42,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
