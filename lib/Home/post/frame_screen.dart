import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {

  PageController controller=PageController();
  final List<Widget> _list=<Widget>[
    const Square(),
    const Vertical(),
    const Horizontal()

  ];

  int _curr=0;
  List<String> names=['Square','Vertical','Horizontal'];

  @override
  Widget build(BuildContext context) {
    return
         Column(
           children: [
             SizedBox(
               height: 500,
               width: 400,
               child: PageView(
                scrollDirection: Axis.horizontal,

                // reverse: true,
                // physics: BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (number){
                  setState(() {
                    _curr=number;
                  });
                },
                children:
                _list,
                   ),
             ),
             Row(
               children: [
                 IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: (){
                   controller.animateToPage(--_curr, duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
                 }),
                 // CustomText_16_500(text: '${names.elementAt(index)}'),
                 IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: (){
                   controller.animateToPage(++_curr, duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);

                 }),
               ],
             )


           ],
         );
  }
}

class Square extends StatelessWidget {
  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 342,
          width: 342,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
          border: Border.all()
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.arrow_back_ios),
            //CustomText_16_500(text: 'Square'),
            Icon(Icons.arrow_forward_ios),

          ],
        )
      ],
    );
  }
}
class Vertical extends StatelessWidget {
  const Vertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 420,
          width: 342,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all()
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.navigate_before),
          //  CustomText_16_500(text: 'Vertical'),
            Icon(Icons.navigate_next),

          ],
        )
      ],
    );
  }
}

class Horizontal extends StatelessWidget {
  const Horizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 200,
          width: 342,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all()
          ),
        )
    );
  }
}


class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController pageController = PageController();
  int pageChanged = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: PageView(
            pageSnapping: true,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
              });
              if (kDebugMode) {
                print(pageChanged);
              }
            },
            children: [
              Container(
                color: Colors.indigo,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.brown,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
