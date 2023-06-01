import 'package:flutter/material.dart';

class RequestSampleCard extends StatefulWidget {
  const RequestSampleCard({Key? key}) : super(key: key);

  @override
  RequestSampleCardState createState() => RequestSampleCardState();
}

class RequestSampleCardState extends State<RequestSampleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                image: AssetImage('assets/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.85),
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.65),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.45),
                  ],
                ),
              ),
              child: const SizedBox(
                height: 200,
                width: double.infinity,
              )),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SmartBin Alert',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'SmartBin Alert is an app that helps you to monitor the status of your trash bin.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'You can also request for a trash pickup service.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
