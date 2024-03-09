import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:todo/controllers/add_data_controller.dart';
import 'package:todo/widgets/bottom_sheet.dart';
import 'package:todo/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now(); // Get current date and time
    final formattedDate = DateFormat('EEEE, d MMMM').format(now); // Format date

    return GetBuilder<NewDataController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade200,
              radius: 25,
              child: Image.asset(
                'assets/men.png',
                height: 35,
                width: 35,
              ),
            ),
            title: Text(
              'Hello I\'m',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
            subtitle: const Text(
              'Prashant Patel',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your\'s Task',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          formattedDate, // Display formatted date
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD5E8FA),
                            foregroundColor: Colors.blue.shade700,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () =>
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              context: context,
                              builder: (context) => const AddNewTaskModel(),
                            ),
                        child: const Text('+ New Task'))
                  ],
                ),
                const Gap(20),
                ListView.builder(
                  itemCount:ctrl.tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      Dismissible(
                        key: Key(ctrl.tasks[index].id.toString()), // Ensure unique key
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ctrl.deleteTask(ctrl.tasks[index].id ?? ''); // Call delete function from controller
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          padding: const EdgeInsets.only(right: 20),
                          child:  const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: CardWidget(
                          title: ctrl.tasks[index].title ?? '',
                          description: ctrl.tasks[index].description ?? '',
                          isValue: ctrl.tasks[index].isDone ?? false,
                          time: ctrl.tasks[index].time ?? '',
                          category: ctrl.tasks[index].category ?? '',
                          fetchedDate: ctrl.tasks[index].date ?? '',
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
