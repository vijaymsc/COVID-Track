import 'package:flutter/material.dart';
import 'secondscreen.dart';

class startscreen extends StatefulWidget {
  const startscreen({Key? key}) : super(key: key);

  @override
  _startscreenState createState() => _startscreenState();
}

class _startscreenState extends State<startscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/covid19.png",
                      ),
                      fit: BoxFit.cover),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    'COVID_19',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'STAY HOME Stay SAFE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => details()),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      //color: Colors.deepOrange,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
