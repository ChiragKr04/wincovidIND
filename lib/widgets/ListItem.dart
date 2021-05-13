import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c/models/ResourceScript.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ShowDialog.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.resourceList,
    @required this.index,
  }) : super(key: key);

  final List<ResourceScript> resourceList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTileCard(
        baseColor: Colors.cyan[50],
        title: Text(
          resourceList[index].items,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Color(0xFFFF8211),
            ),
          ),
        ),
        expandedColor: Colors.cyan[50],
        subtitle: Text(
          "Quantity: ${resourceList[index].quantity}",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Color(0xFF000000),
            ),
          ),
        ),
        children: [
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "${resourceList[index].description}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "${resourceList[index].address}, ${resourceList[index].district}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Mobile No. ${resourceList[index].mobile}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onPressed: () {
                  _showMyDialog(resourceList[index].mobile, context, 0);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.call),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Call'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onPressed: () {
                  _showMyDialog(resourceList[index].mobile, context, 1);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/whatsappicon.png',
                      ),
                      height: 26,
                      width: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Whatsapp'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onPressed: () {
                  _openLocation(resourceList[index].address,
                      resourceList[index].district);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.my_location_sharp,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Location'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openLocation(String address, String district) async {
    String query = Uri.encodeComponent("$address $district");
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  _showMyDialog(String mobile, BuildContext context, int which) {
    final mobiles = mobile.split(',');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDialog(
          mobiles: mobiles,
          which: which,
        );
      },
    );
  }
}
