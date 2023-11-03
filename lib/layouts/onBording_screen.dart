import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_shop_app/sharedPref.dart';
import 'Login.dart';

bool IsLast = false;

class onbordinModel {
  String? image;
  String? title;
  String? body1;
  String? body2;
  onbordinModel(
      {required this.image,
      required this.body1,
      required this.title,
      required this.body2});
}

class onBordingScreen extends StatefulWidget {
  const onBordingScreen({Key? key}) : super(key: key);

  @override
  _onBordingScreenState createState() => _onBordingScreenState();
}

class _onBordingScreenState extends State<onBordingScreen> {
  @override
  var bordControl = PageController();
  List<onbordinModel> onBording = [
    onbordinModel(
      image:
          'https://i.pinimg.com/564x/d4/43/c9/d443c970c669eb945ff047dd6dbd171b.jpg',
      body1: 'ONLINE ORDER ',
      title: ' smart online shopping cart',
      body2: 'Make an order sitting on sofa',
    ),
    onbordinModel(
      image:
          'https://i.pinimg.com/736x/38/80/a9/3880a9f711a2cdf57f7bce5dd8eb4a5d.jpg',
      body1: 'Online shopping Grocery ',
      title: 'Select & memorize your future purchases',
      body2: '50% Discount',
    ),
    onbordinModel(
      image:
          'https://i.pinimg.com/564x/72/04/f4/7204f436f2068d65e72f4699901caa98.jpg',
      body1: 'Online Shopping Fast Delivery  ',
      title: 'Buy using your smartphone  ',
      body2: 'Pay and choose online',
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                CacheHelper.saveData(key: 'onbording', value: true)
                    .then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              )),
          Expanded(
            child: PageView.builder(
              controller: bordControl,
              itemBuilder: (context, index) => BuildPageView(onBording[index]),
              itemCount: onBording.length,
              onPageChanged: (int index) {
                if (index == onBording.length - 1) {
                  setState(() {
                    IsLast = true;
                  });
                } else {
                  setState(() {
                    IsLast = false;
                  });
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: bordControl,
                count: onBording.length,
                effect: const WormEffect(
                  dotColor: Colors.black26,
                  dotHeight: 16,
                  dotWidth: 16,
                  activeDotColor: Colors.purple,
                  radius: 10,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            children: [
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (IsLast == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    print({'$IsLast'});

                    bordControl.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.ease);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),
                backgroundColor: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

Widget BuildPageView(onbordinModel OnBording) => Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image(

            // fit: BoxFit.cover,

            width: 300,
            image: NetworkImage(
              '${OnBording.image}',
            )),
        SizedBox(
          height: 40,
        ),
        Text(
          '${OnBording.body1}',
          style: TextStyle(
              fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text('${OnBording.title}',
            style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text('${OnBording.body2}',
            style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
