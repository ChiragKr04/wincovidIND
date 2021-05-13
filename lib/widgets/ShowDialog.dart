import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({
    Key key,
    @required this.mobiles,
    @required this.which,
  }) : super(key: key);

  final List<String> mobiles;
  final int which;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "Call",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 19),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mobiles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: which == 1
                      ? () {
                          launch("http://wa.me/${mobiles[index]}");
                        }
                      : () {
                          launch("tel://${mobiles[index]}");
                        },
                  title: Text("${mobiles[index]}"),
                  leading: which == 1
                      ? CircleAvatar(
                          child: Image.asset(
                            "assets/images/whatsappicon.png",
                          ),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF0059A7),
                          child: Icon(
                            Icons.call,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
