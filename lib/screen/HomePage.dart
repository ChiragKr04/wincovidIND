import 'package:flutter/material.dart';
import 'package:flutter_app_c/controller/ResourceController.dart';
import 'package:flutter_app_c/models/ResourceScript.dart';
import 'package:flutter_app_c/widgets/ListItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ResourceScript> resourceList = <ResourceScript>[];
  String _chosenValueCategory = "All";
  String _chosenValueDistrict = "All";
  List results = [];
  List prevResult = [];
  String queryCategory = "All";
  String queryDistrict = "All";
  bool isLoading = true;

  @override
  void dispose() {
    if (mounted) {
      setState(() {
        this.resourceList = <ResourceScript>[];
        this.isLoading = false;
      });
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ResourceController().getFeedbackList().then((resourceList) {
      setState(() {
        this.resourceList = resourceList;
        print(resourceList.toString());
        isLoading = false;
      });
    });
  }

  Future<void> _refreshList() async {
    setState(() {
      isLoading = true;
    });
    ResourceController().getFeedbackList().then((resourceList) {
      setState(() {
        this.resourceList = resourceList;
        print(resourceList.toString());
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _refreshList,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      sortByCategory(),
                      sortByDistrict(),
                    ],
                  ),
                  Expanded(
                    child: queryCategory == "All" && queryDistrict == "All"
                        ? ListView.builder(
                            itemCount: resourceList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItem(
                                  resourceList: resourceList,
                                  index: index,
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItem(
                                  resourceList: results,
                                  index: index,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget noInfoWidget() {
    return Center(
      child: Container(
        child: Text("No Information"),
      ),
    );
  }

  Widget sortByCategory() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: _chosenValueCategory,
              //elevation: 5,
              style: TextStyle(color: Colors.black),
              items: [
                'All',
                'Beds',
                'Oxygen',
                'Medicines',
                'Injections',
                'Social Services',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _chosenValueCategory = value;
                  queryCategory = value;
                  print(_chosenValueCategory);
                  findCategory(_chosenValueCategory);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sortByDistrict() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  "Area",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: _chosenValueDistrict,
              //elevation: 5,
              style: TextStyle(color: Colors.black),
              items: [
                'All',
                'North Delhi',
                'East Delhi',
                'South Delhi',
                'West Delhi',
                'Noida',
                'Gurugram',
                "Other",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _chosenValueDistrict = value;
                  queryDistrict = value;
                  print(_chosenValueDistrict);
                  findDistrict(_chosenValueDistrict);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void findCategory(String query) {
    setState(() {
      isLoading = true;
    });
    results = resourceList
        .where((element) => element.items
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    // print(results);
    setState(() {
      isLoading = false;
    });
  }

  void findDistrict(String query) {
    setState(() {
      isLoading = true;
    });
    print(query);
    if (queryDistrict == "All" && queryCategory == "All") {
      results = resourceList
          .where((element) => element.district
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    if (queryDistrict != "All" && queryCategory != "All") {
      results = results
          .where((element) => element.district
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .where((element) => element.items
              .toString()
              .toLowerCase()
              .contains(queryCategory.toLowerCase()))
          .toList();
    }
    setState(() {
      print(results);
      isLoading = false;
    });
  }
}
