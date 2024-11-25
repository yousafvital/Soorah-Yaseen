// about_content.dart
import 'package:flutter/material.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          'Transforming Business with Mobile Development Excellence',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'At Vital Steer, our team of seasoned mobile developers is dedicated to enhancing your mobile presence with powerful Android and iOS applications. We focus on creating seamless, intuitive, and high-performance apps that meet your business objectives and captivate users. With a commitment to innovative design, optimized performance, and end-to-end support, we deliver solutions that drive engagement, growth, and lasting value.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Our Mission',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'To shape the future of mobile experiences by combining innovation with expertise. We empower businesses to engage their audience, scale effortlessly, and thrive in a competitive landscape.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Custom Code',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Delivering mobile solutions that connect people and ideas. Vital Steer brings passion, creativity, and technical excellence to every project.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
