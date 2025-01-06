import 'package:flutter/material.dart';

import '../../../utils/responsive.dart';

class DetailTitleListView extends StatefulWidget {
  bool isTablet;
  DetailTitleListView({required this.isTablet});
  @override
  _DetailTitleListViewState createState() => _DetailTitleListViewState();
}

class _DetailTitleListViewState extends State<DetailTitleListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveHelper.height(40),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = selectedIndex == index;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xff820002) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Center(
                            child: Text(
                              "Statistics",
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveHelper.fontSize(widget.isTablet ? 7 : 11),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
