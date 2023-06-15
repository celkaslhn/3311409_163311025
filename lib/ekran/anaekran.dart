import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _imageAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.repeat(reverse: true);

    _imageAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                  "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t ARAC / PLAKA  \n\n  UYGULAMASI'NA  HOŞGELDİNİZ !!! ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 25,
            ),
            Text(" Bu uygulama ile;\n\n ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            Text(
              "\t.. Araç bilgilerinizi kaydedebilirsiniz \n\n\t.. Kaydettiğiniz bilgileri liste halinde tekrar görebilirsiniz \n\n\t.. İstediğiniz aracın plaka numarası ya da sahibinin ismi ile arattığınızda arac bilgilerine ulaşabilirsiniz",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageAnimation.value,
                      child: Image.asset(
                        'assets/images/a1.jpg',
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageAnimation.value,
                      child: Image.asset(
                        'assets/images/a2.jpg',
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageAnimation.value,
                      child: Image.asset(
                        'assets/images/a3.jpg',
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
