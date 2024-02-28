import 'package:flutter/material.dart';
import 'package:simple_app/colors.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {

  PageController controller=PageController();
  List<Widget> _list=<Widget>[
    Square(),
    Vertical(),
    Horizontal()

  ];

  int _curr=0;
  List<String> names=['Square','Vertical','Horizontal'];

  @override
  Widget build(BuildContext context) {
    return
         Column(
           children: [
             Container(
               height: 500,
               width: 400,
               child: PageView(
                children:
                _list,
                scrollDirection: Axis.horizontal,

                // reverse: true,
                // physics: BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (num){
                  setState(() {
                    _curr=num;
                  });
                },
                   ),
             ),
             Row(
               children: [
                 IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                   controller.animateToPage(--_curr, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
                 }),
                 // CustomText_16_500(text: '${names.elementAt(index)}'),
                 IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
                   controller.animateToPage(++_curr, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

                 }),
               ],
             )


           ],
         );
  }
}

class Square extends StatelessWidget {
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
        Row(
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
        Row(
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


class PageView_Screen extends StatefulWidget {
  const PageView_Screen({super.key});

  @override
  State<PageView_Screen> createState() => _PageView_ScreenState();
}

class _PageView_ScreenState extends State<PageView_Screen> {
  PageController pageController = PageController();
  int pageChanged = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: PageView(
            pageSnapping: true,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
              });
              print(pageChanged);
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
