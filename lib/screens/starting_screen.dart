import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/screens/home_screen.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
            child: Lottie.asset('assets/todo.json'),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'Welcome to Doingly',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Doingly will help you stay\n'
            'organised and perform your\n'
            'tasks faster',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.red[200],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 65),
                  child: Row(
                    children: [
                      const Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        'assets/next.png',
                        height: 30,
                        width: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
