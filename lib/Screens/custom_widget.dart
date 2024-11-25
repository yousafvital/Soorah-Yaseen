import 'package:bookfx/bookfx.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  BookController bookController = BookController();

  // List of widgets/pages
  final List<Widget> pages = [
    Page1(),
    Page2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookFx(
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        pageCount: pages.length,
        currentPage: (index) {
          int reverseIndex = pages.length - 1 - index;
          return pages[index];
        },
        lastCallBack: (index) {
          int reverseIndex = pages.length - 1 - index;
          print('Previous page index (reversed): $reverseIndex');
        },
        nextCallBack: (index) {
          int reverseIndex = pages.length - 1 - index;
          print('Next page index (reversed): $reverseIndex');
        },
        nextPage: (index) {
          int reverseIndex = pages.length - 1 - index;
          return pages[index];
        },
        controller: bookController,
      ),
    );
  }
}

// Page 1 with Button
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Print a message when the button is clicked
            print('Button on Page 1 clicked!');
          },
          child: const Text(
            'Show Message',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Example additional pages
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Page 2',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
