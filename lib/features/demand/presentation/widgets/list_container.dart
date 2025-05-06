import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListContainer extends StatelessWidget {
  final String title;
  final List content;
  const ListContainer({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      width: 360,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 20),
            SizedBox(
              height: 100,
              child:
                  content.isEmpty
                      ? Center(child: Text("No data available"))
                      : ListView.builder(
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          final item = (content[index] as Map<String, dynamic>);
                          final key = item.keys.first;
                          final value = item[key];
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Colors.grey[300],
                              height: 40,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/${item.keys.first}.svg",
                                      width: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(item.keys.first),
                                    Spacer(),
                                    Text(
                                      "Amount ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      value,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
}
