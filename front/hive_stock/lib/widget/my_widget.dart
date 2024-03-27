import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF5FAFD),
      ),
      padding: const EdgeInsets.fromLTRB(27, 14, 65, 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 41),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  width: 28.4,
                  height: 11.1,
                  child: Image.asset('assets/your_image.png'),
                ),
                Row(
                  children: [
                    Image.asset('assets/image1.png', width: 20, height: 14),
                    const SizedBox(width: 4),
                    Image.asset('assets/image2.png', width: 16, height: 14),
                    const SizedBox(width: 4),
                    Image.asset('assets/image3.png', width: 25, height: 14),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7.5, 0, 52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFEFF4F7),
                  ),
                  padding: const EdgeInsets.fromLTRB(35, 21, 35, 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage('assets/your_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 289,
                        height: 363,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'You’re in Control',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF40484B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Effortlessly track your stock, manage orders, and streamline your operations with ease.',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF40484B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF02677D),
                            ),
                          ),
                          SizedBox(width: 14.3),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF4C626A),
                            ),
                          ),
                          SizedBox(width: 14.3),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF4C626A),
                            ),
                          ),
                          SizedBox(width: 14.3),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF4C626A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFF02677D),
            ),
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(width: 9.8),
                Container(
                  width: 15,
                  height: 12,
                  child: Image.asset('assets/your_image.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
