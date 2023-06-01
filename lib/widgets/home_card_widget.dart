import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smartbin_alert/models/bin_model.dart';
import 'package:smartbin_alert/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCardWidget extends StatefulWidget {
  final BinModel bin;
  const HomeCardWidget({Key? key, required this.bin}) : super(key: key);

  @override
  HomeCardWidgetState createState() => HomeCardWidgetState();
}

class HomeCardWidgetState extends State<HomeCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bin.id ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // location iconbutton
                    Row(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(8.0),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          highlightColor: Colors.white,
                          tooltip: "Bin Location",
                          onPressed: () {
                            openGoogleMapsLocation(widget.bin.location ?? "");
                          },
                          icon:
                              const Icon(Icons.pin_drop, color: tertiaryColor),
                        ),
                        IconButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(8.0),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          highlightColor: Colors.white,
                          tooltip: "Bin Location",
                          onPressed: () {},
                          icon: const Icon(Icons.refresh, color: tertiaryColor),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerRight,
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 8.0,
                        percent: widget.bin.fill!.toDouble() / 100.0,
                        center: Text(
                          "${(widget.bin.fill ?? 0.0)}%",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        progressColor: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future openGoogleMapsLocation(String locationUrl) async {
    try {
      Uri url = Uri.parse(locationUrl);
      await launchUrl(url);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
