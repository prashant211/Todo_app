import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class CardWidget extends StatefulWidget {
  const CardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.isValue,
    required this.time,
    required this.category,
    required this.fetchedDate,
  }) : super(key: key);

  final String title;
  final String description;
  final bool isValue;
  final String time;
  final String category;
  final String fetchedDate;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isValue;
  }

  Color getCategoryColor(String category) {
    print('Category received: $category');
    switch (category) {
      case 'Learning':
        return Colors.green;
      case 'Work':
        return Colors.blue;
      case 'General':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color categoryColor = getCategoryColor(widget.category);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Parse the date from Firestore string to DateTime
    DateTime firebaseDate = DateFormat('yyyy-MM-dd').parse(widget.fetchedDate);

    int differenceInDays = firebaseDate.difference(currentDate).inDays;

    // Determine the text to display based on the difference in days
    String displayText;
    if (differenceInDays == 0) {
      displayText = 'Tomorrow';
    } else if (differenceInDays >0) {
      displayText = DateFormat('yyyy-MM-dd').format(firebaseDate);
    } else {
      displayText = 'Today';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height *
          0.13, // Adjust the height percentage as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.title),
                    subtitle: Text(widget.description),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Colors.grey.shade200,
                  ),
                  Row(
                    children: [
                      Text(displayText), // Display "Today" or fetched date
                      const Gap(12),
                      Text(widget.time),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
