import 'package:flutter/material.dart';
import 'package:my_manager/widget/custom_buttom.dart';

class NotFound404 extends StatelessWidget {
  const NotFound404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/gif/404.gif",
              colorBlendMode: BlendMode.color,
              color: Colors.black,
              width: 400,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Page not found",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "We are sorry to let you know that the page you are looking for is currently unavailable. Please return home and keep using.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            const Spacer(flex: 10),
            CustomButton(
              buttonColor: Colors.black,
              fullScreenButton: true,
              textColor: Colors.white,
              fontSize: 16,
              borderRadius: 4,
              fontWeight: FontWeight.w300,
              buttonText: "Return To Home",
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              onPressed: () {},
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
