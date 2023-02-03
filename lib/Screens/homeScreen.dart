import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:khanintlexpress/AppBar/customAppbar.dart';
import 'package:khanintlexpress/Screens/pickupRequestScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

import '../Widgets/blurryContainer.dart';
import 'bookingScreen.dart';

final Uri _url = Uri.parse('https://www.facebook.com/KhanInternationalExpress');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

Future<void> _trackDhl(Uri dhlUrl) async {

  if (!await launchUrl(dhlUrl)) {
    throw 'Could not launch $dhlUrl';
  }
}

Future<void> _trackFedex(Uri fedexUrl) async {

  if (!await launchUrl(fedexUrl)) {
    throw 'Could not launch $fedexUrl';
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

TextEditingController dhlTrackingController = new TextEditingController();
TextEditingController fedexTrackingController = new TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const HomeMobile();
          } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1000) {
            return const HomeMobile();
          } else {
            return const HomeDesktop();
          }
        },
      ),
    );
  }
}

class HomeMobile extends StatelessWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final IFrameElement _iframeElement = IFrameElement();

    // _iframeElement.height = '500';
    // _iframeElement.width = '500';
    _iframeElement.src = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14609.60405216829!2d90.39845351126549!3d23.733075183066106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755b85af186ad55%3A0xe15ec913ae621386!2sKhan%20International%20Express%20Travel%20Agency!5e0!3m2!1sen!2sbd!4v1667901637961!5m2!1sen!2sbd';
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iframeElement,
    );

    Widget _iframeWidget;
    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );

    return Stack(
      children: [

        Positioned(
          top: 200,
          left: 30,
          child: GradientBall(
            colors: [
              darkTheme ? Colors.deepOrange.withOpacity(0.2) : Colors.deepOrange,
              darkTheme ? Colors.amber.withOpacity(0.2) : Colors.amber,
            ],
          ),
        ),
        Positioned(
          top: 400,
          right: 10,
          child: GradientBall(
            size: Size.square(200),
            colors: [
              darkTheme ? Colors.blue.withOpacity(0.2) : Colors.blue,
              darkTheme ? Colors.purple.withOpacity(0.2) : Colors.purple,
            ],
          ),
        ),

        ListView(
          children: [
            Column(
              children: [

                //Slideshow
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          //borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 16/7,
                            child: ImageSlideshow(
                              height: 500,
                              autoPlayInterval: 5000,
                              isLoop: true,
                              /// The color to paint the indicator.
                              indicatorColor: Colors.blue,
                              /// The color to paint behind th indicator.
                              indicatorBackgroundColor: Colors.grey,
                              children: [
                                Image.asset('assets/images/ad.png',
                                  fit: BoxFit.cover,
                                ),

                                Image.asset('assets/images/ad5.png',
                                  fit: BoxFit.cover,
                                ),

                                Image.asset('assets/images/ad6.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),

                //Social Media
                Padding(
                  padding: EdgeInsets.all(0),
                  child: BlurryContainer(
                    color: darkTheme ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.8),
                    blur: 10,
                    elevation: 6,
                    padding: EdgeInsets.all(10),
                    //borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [

                        SizedBox(height: 10,),

                        //About Us
                        Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 25,
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text(
                          'Khan International Express is one of the leading companies in Bangladesh. We handle time-critical parcels, documents, garment items and other goods',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text(
                          'A locally owned and operated courier service with over 20 years experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text(
                          'Cheapest Prices Guaranteed!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                          ),
                        ),

                        SizedBox(height: 20,),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.push(context, MaterialPageRoute(builder: (c) => BookingScreen()));
                        //       },
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        //         decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.circular(20),
                        //         ),
                        //         child: Text(
                        //           'Request for flight booking',
                        //           style: TextStyle(
                        //             color: darkTheme ? Colors.black : Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //     SizedBox(width: 20,),
                        //
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.push(context, MaterialPageRoute(builder: (c) => PickupRequestScreen()));
                        //       },
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        //         decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.circular(20),
                        //         ),
                        //         child: Text(
                        //           'Send pickup request',
                        //           style: TextStyle(
                        //             color: darkTheme ? Colors.black : Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context, MaterialPageRoute(builder: (c) => BookingScreen()));
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        //     decoration: BoxDecoration(
                        //       color: Colors.blue,
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: Text(
                        //       'Request for flight booking',
                        //       style: TextStyle(
                        //         color: darkTheme ? Colors.black : Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => PickupRequestScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Send pickup request',
                              style: TextStyle(
                                color: darkTheme ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Social Media',
                            style: TextStyle(
                              color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.facebook,color: Colors.blue,size: 40,),

                                  SizedBox(width: 10,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Facebook',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Visibility(
                                        visible: MediaQuery.of(context).size.width < 400 ? false : true,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5,),

                                            Text(
                                              'khaninternationalexpress',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: darkTheme ? Colors.white : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:  Colors.blue,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                  ),
                                  minimumSize: const Size(100, 40), //////// HERE
                                ),
                                onPressed: _launchUrl,
                                child: const Text('Link',style: TextStyle(fontWeight: FontWeight.bold,),),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.whatsapp,color: Colors.green,size: 40,),

                                  SizedBox(width: 10,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Whatsapp',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Visibility(
                                        visible: MediaQuery.of(context).size.width < 400 ? false : true,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5,),

                                            Text(
                                              '+880 1915-808030',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: darkTheme ? Colors.white : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),

                              // Row(
                              //   children: [
                              //     ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         primary: Colors.green,
                              //         onPrimary: Colors.white,
                              //         elevation: 3,
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.only(
                              //               topLeft: Radius.circular(30),
                              //               bottomLeft: Radius.circular(30),
                              //             )
                              //         ),
                              //         minimumSize: const Size(50, 40), //////// HERE
                              //       ),
                              //       onPressed: ()
                              //       {
                              //         _makePhoneCall('tel:01915808030');
                              //       },
                              //       //child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                              //       child: Icon(Icons.message,color: Colors.white,size: 15,),
                              //     ),
                              //
                              //     ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         primary: Colors.green,
                              //         onPrimary: Colors.white,
                              //         elevation: 3,
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.only(
                              //               topRight: Radius.circular(30),
                              //               bottomRight: Radius.circular(30),
                              //             )
                              //         ),
                              //         minimumSize: const Size(50, 40), //////// HERE
                              //       ),
                              //       onPressed: ()
                              //       {
                              //         _makePhoneCall('tel:01915808030');
                              //       },
                              //       //child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                              //       child: Icon(Icons.phone,color: Colors.white,size: 15,),
                              //     ),
                              //   ],
                              // ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                  ),
                                  minimumSize: const Size(100, 40), //////// HERE
                                ),
                                onPressed: ()
                                {
                                  _makePhoneCall('tel:01915808030');
                                },
                                child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.whatsapp,color: Colors.green,size: 40,),

                                  SizedBox(width: 10,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Whatsapp',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Visibility(
                                        visible: MediaQuery.of(context).size.width < 400 ? false : true,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5,),

                                            Text(
                                              '+880 1689-848471',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: darkTheme ? Colors.white : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                  ),
                                  minimumSize: const Size(100, 40), //////// HERE
                                ),
                                onPressed: ()
                                {
                                  _makePhoneCall('tel:01689848471');
                                },
                                child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text(
                          'Tracking',
                          style: TextStyle(
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20,),

                        //dhl Tracking Number
                        TextField(
                          controller: dhlTrackingController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter DHL tracking number',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            //border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey,),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(5),
                              child: TextButton(
                                onPressed: () {
                                  _trackDhl(Uri.parse('https://www.dhl.com/bd-en/home/tracking/tracking-express.html?submit=1&tracking-id=${dhlTrackingController.text}'));
                                },
                                child: Text('Track',
                                  style: TextStyle(
                                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        //fedex Tracking number
                        TextField(
                          controller: fedexTrackingController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Fedex tracking number',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            //border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey,),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(5),
                              child: TextButton(
                                onPressed: () {
                                  _trackFedex(Uri.parse('https://www.fedex.com/fedextrack/?trknbr=${fedexTrackingController.text}'));
                                },
                                child: Text('Track',
                                  style: TextStyle(
                                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        //Map
                        Text(
                          'Map',
                          style: TextStyle(
                            color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20,),

                        ClipRRect(
                          //borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 16/10,
                            child: SizedBox(
                              child: _iframeWidget,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                //Footer
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: darkTheme ? Colors.black12 : Colors.grey.shade100.withOpacity(0.9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Our Address',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('147 Fakirapool, D.I.T Ext Road',style: TextStyle(color: Colors.grey),),
                            Text('Dhaka-1000, Bangladesh',style: TextStyle(color: Colors.grey),),
                          ],
                        ),

                      ],
                    ),
                ),

                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: darkTheme ? Colors.black12 : Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Text(
                        '2022 © Copyright Egon Castle'
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ],
    );
  }
}

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final IFrameElement _iframeElement = IFrameElement();

    // _iframeElement.height = '500';
    // _iframeElement.width = '500';
    _iframeElement.src = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14609.60405216829!2d90.39845351126549!3d23.733075183066106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755b85af186ad55%3A0xe15ec913ae621386!2sKhan%20International%20Express%20Travel%20Agency!5e0!3m2!1sen!2sbd!4v1667901637961!5m2!1sen!2sbd';
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iframeElement,
    );

    Widget _iframeWidget;
    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );

    return Stack(
      children: [

        Positioned(
          top: 300,
          left: 30,
          child: GradientBall(
            size: Size.square(250),
            colors: [
              darkTheme ? Colors.deepOrange.withOpacity(0.2) : Colors.deepOrange,
              darkTheme ? Colors.amber.withOpacity(0.2) : Colors.amber,
            ],
          ),
        ),
        Positioned(
          top: 400,
          right: 30,
          child: GradientBall(
            size: Size.square(400),
            colors: [
              darkTheme ? Colors.blue.withOpacity(0.2) : Colors.blue,
              darkTheme ? Colors.purple.withOpacity(0.2) : Colors.purple,
            ],
          ),
        ),

        ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  //borderRadius: BorderRadius.circular(20),
                                  child: AspectRatio(
                                    aspectRatio: 16/6,
                                    child: ImageSlideshow(
                                      height: 500,
                                      autoPlayInterval: 5000,
                                      isLoop: true,
                                      /// The color to paint the indicator.
                                      indicatorColor: Colors.blue,
                                      /// The color to paint behind th indicator.
                                      indicatorBackgroundColor: Colors.grey,
                                      children: [
                                        Image.asset('assets/images/ad.png',
                                          fit: BoxFit.cover,
                                        ),

                                        Image.asset('assets/images/ad5.png',
                                          fit: BoxFit.cover,
                                        ),

                                        Image.asset('assets/images/ad6.png',
                                          fit: BoxFit.cover,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                    child: AspectRatio(
                                      aspectRatio: 16/1.7,
                                      child: ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                          child: AspectRatio(
                                            aspectRatio: 16/2.5,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Welcome to Khan International Express',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15 * MediaQuery.of(context).size.width * 0.001,
                                                          ),
                                                        ),
                                                        SizedBox(height: 3,),
                                                        Text('A courier service you can depend on',
                                                          style: TextStyle(
                                                            fontSize: 10 * MediaQuery.of(context).size.width * 0.001,
                                                            color: Colors.white.withOpacity(0.8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // ElevatedButton(
                                                    //   style: ElevatedButton.styleFrom(
                                                    //     primary: Colors.blue,
                                                    //     onPrimary: Colors.white,
                                                    //     shadowColor: Colors.greenAccent,
                                                    //     elevation: 3,
                                                    //     shape: RoundedRectangleBorder(
                                                    //         borderRadius: BorderRadius.circular(32.0)
                                                    //     ),
                                                    //     minimumSize: const Size(100, 40), //////// HERE
                                                    //   ),
                                                    //   onPressed: () {},
                                                    //   child: const Text('Download our app'),
                                                    // ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),

                            SizedBox(height: 20,),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  //About Us
                                  Text(
                                    'About Us',
                                    style: TextStyle(
                                      fontSize: 20 * MediaQuery.of(context).size.width * 0.001,
                                      color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  Text(
                                    'Khan International Express is one of the leading companies in Bangladesh. We handle time-critical parcels, documents, garment items and other goods',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15 * MediaQuery.of(context).size.width * 0.001,
                                      color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20,),

                            Text(
                              'A locally owned and operated courier service with over 20 years experience.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15 * MediaQuery.of(context).size.width * 0.001,
                                color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                              ),
                            ),

                            SizedBox(height: 20,),

                            Text(
                              'Cheapest Prices Guaranteed!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20 * MediaQuery.of(context).size.width * 0.001,
                                color: darkTheme ? Colors.white.withOpacity(0.8) : Colors.black,
                              ),
                            ),

                            SizedBox(height: 30,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(context, MaterialPageRoute(builder: (c) => BookingScreen()));
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                //     decoration: BoxDecoration(
                                //       color: Colors.blue,
                                //       borderRadius: BorderRadius.circular(20),
                                //     ),
                                //     child: Text(
                                //       'Book a flight',
                                //       style: TextStyle(
                                //         color: darkTheme ? Colors.black : Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                //
                                // SizedBox(width: 20,),

                                // GlowButton(
                                //   onPressed: () {
                                //
                                //   },
                                //   child: Text(
                                //     'Send Pickup Request',
                                //     style: TextStyle(
                                //       color: darkTheme ? Colors.black : Colors.white,
                                //     ),
                                //   ),
                                // ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (c) => PickupRequestScreen()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Send pickup request',
                                      style: TextStyle(
                                        color: darkTheme ? Colors.black : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [

                              Container(
                                //margin: EdgeInsets.fromLTRB(10, 20, 20, 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: darkTheme ? Colors.black45 : Colors.grey.shade100.withOpacity(0.9),
                                  //borderRadius: BorderRadius.circular(20),
                                ),

                                child: Column(
                                  children: [
                                    //Social Media
                                    Text(
                                      'Social Media',
                                      style: TextStyle(
                                        color: darkTheme ? Colors.white : Colors.black,
                                        fontSize: 20 * MediaQuery.of(context).size.width * 0.001,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    
                                    //Facebook
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.facebook,color: Colors.blue,size: 40,),

                                              SizedBox(width: 10,),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Facebook',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  Visibility(
                                                    visible: MediaQuery.of(context).size.width < 1200 ? false : true,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 5,),

                                                        Text(
                                                          'khaninternationalexpress',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: darkTheme ? Colors.white : Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:  Colors.blue,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0)
                                              ),
                                              minimumSize: const Size(100, 40), //////// HERE
                                            ),
                                            onPressed: _launchUrl,
                                            child: const Text('Link',style: TextStyle(fontWeight: FontWeight.bold,),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10,),

                                    //Whatsapp
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.whatsapp,color: Colors.green,size: 40,),

                                              SizedBox(width: 10,),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Whatsapp',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  Visibility(
                                                    visible: MediaQuery.of(context).size.width < 1200 ? false : true,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 5,),

                                                        Text(
                                                          '+880 1915-808030',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: darkTheme ? Colors.white : Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),

                                          // Row(
                                          //   children: [
                                          //     ElevatedButton(
                                          //       style: ElevatedButton.styleFrom(
                                          //         primary: Colors.green,
                                          //         onPrimary: Colors.white,
                                          //         elevation: 3,
                                          //         shape: RoundedRectangleBorder(
                                          //             borderRadius: BorderRadius.only(
                                          //               topLeft: Radius.circular(30),
                                          //               bottomLeft: Radius.circular(30),
                                          //             )
                                          //         ),
                                          //         minimumSize: const Size(50, 40), //////// HERE
                                          //       ),
                                          //       onPressed: ()
                                          //       {
                                          //         _makePhoneCall('tel:01915808030');
                                          //       },
                                          //       //child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                                          //       child: Icon(Icons.message,color: Colors.white,size: 15,),
                                          //     ),
                                          //
                                          //     ElevatedButton(
                                          //       style: ElevatedButton.styleFrom(
                                          //         primary: Colors.green,
                                          //         onPrimary: Colors.white,
                                          //         elevation: 3,
                                          //         shape: RoundedRectangleBorder(
                                          //             borderRadius: BorderRadius.only(
                                          //               topRight: Radius.circular(30),
                                          //               bottomRight: Radius.circular(30),
                                          //             )
                                          //         ),
                                          //         minimumSize: const Size(50, 40), //////// HERE
                                          //       ),
                                          //       onPressed: ()
                                          //       {
                                          //         _makePhoneCall('tel:01915808030');
                                          //       },
                                          //       //child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                                          //       child: Icon(Icons.phone,color: Colors.white,size: 15,),
                                          //     ),
                                          //   ],
                                          // ),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0)
                                              ),
                                              minimumSize: const Size(100, 40), //////// HERE
                                            ),
                                            onPressed: ()
                                            {
                                              _makePhoneCall('tel:01915808030');
                                            },
                                            child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10,),

                                    //Whatsapp
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.whatsapp,color: Colors.green,size: 40,),

                                              SizedBox(width: 10,),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Whatsapp',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  Visibility(
                                                    visible: MediaQuery.of(context).size.width < 1200 ? false : true,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 5,),

                                                        Text(
                                                          '+880 1689-848471',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: darkTheme ? Colors.white : Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0)
                                              ),
                                              minimumSize: const Size(100, 40), //////// HERE
                                            ),
                                            onPressed: ()
                                            {
                                              _makePhoneCall('tel:01689848471');
                                            },
                                            child: const Text('Call',style: TextStyle(fontWeight: FontWeight.bold,),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    
                                    //Tracking
                                    Text(
                                      'Tracking',
                                      style: TextStyle(
                                        color: darkTheme ? Colors.white : Colors.black,
                                        fontSize: 17 * MediaQuery.of(context).size.width * 0.001,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 20,),

                                    //dhl Tracking Number
                                    TextField(
                                      controller: dhlTrackingController,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter DHL tracking number',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        //border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search, color: Colors.grey,),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: TextButton(
                                            onPressed: () {
                                              _trackDhl(Uri.parse('https://www.dhl.com/bd-en/home/tracking/tracking-express.html?submit=1&tracking-id=${dhlTrackingController.text}'));
                                            },
                                            child: Text('Track',
                                              style: TextStyle(
                                                color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),

                                    //fedex Tracking number
                                    TextField(
                                      controller: fedexTrackingController,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter Fedex tracking number',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: darkTheme ? Colors.grey.withOpacity(0.4) : Colors.grey.shade400.withOpacity(0.4),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        //border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search, color: Colors.grey,),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: TextButton(
                                            onPressed: () {
                                              _trackFedex(Uri.parse('https://www.fedex.com/fedextrack/?trknbr=${fedexTrackingController.text}'));
                                            },
                                            child: Text('Track',
                                              style: TextStyle(
                                                color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20,),

                                    //Map-text
                                    Text(
                                      'Map',
                                      style: TextStyle(
                                        color: darkTheme ? Colors.white : Colors.black,
                                        fontSize: 17 * MediaQuery.of(context).size.width * 0.001,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 20,),

                                    //Map
                                    AspectRatio(
                                      aspectRatio: 16/10,
                                      child: SizedBox(
                                        child: _iframeWidget,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          )
                      ),

                    ],
                  ),

                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  //Footer
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: darkTheme ? Colors.black45 : Colors.grey.shade100.withOpacity(0.9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Help Center',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('Contact Us',style: TextStyle(color: Colors.grey),),
                          ],
                        ),

                        SizedBox(width: 20,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Our Address',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('147 Fakirapool, D.I.T Ext Road',style: TextStyle(color: Colors.grey),),
                            Text('Dhaka-1000, Bangladesh',style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                        
                        SizedBox(width: 20,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Language',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('English',style: TextStyle(color: Colors.grey),),
                          ],
                        ),

                      ],
                    )
                  ),

                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: darkTheme ? Colors.black45 : Colors.grey.shade100.withOpacity(0.9),
                    ),
                    child: Center(
                      child: Text(
                          '2022 © Copyright Egon Castle'
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        )
      ],
    );
  }
}

class GradientBall extends StatelessWidget {
  final List<Color> colors;
  final Size size;
  const GradientBall({
    Key? key,
    required this.colors,
    this.size = const Size.square(150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}