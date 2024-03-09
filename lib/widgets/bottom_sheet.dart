import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/add_data_controller.dart';
import 'package:todo/widgets/radio_widget.dart';
import 'package:todo/widgets/text_field_widget.dart';

import '../constants/app_style.dart';
import 'date_time_widget.dart';

class AddNewTaskModel extends StatelessWidget {
  const AddNewTaskModel({super.key});
  String _getCategory(int value) {
    switch (value) {
      case 1:
        return 'Learning';
      case 2:
        return 'Work';
      case 3:
        return 'General';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewDataController>(builder: (ctrl) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Text(
                  'New Task Todo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 1.2,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 12),
              const Text(
                'Title Task',
                style: Appstyle.headingOne,
              ),
              const SizedBox(height: 6),
              TextFieldWidget(
                  txtController: ctrl.titleCtrl,
                  hintText: 'Add Task Name',
                  maxLine: 1),
              const SizedBox(height: 12),
              const Text(
                'Description',
                style: Appstyle.headingOne,
              ),
              const SizedBox(height: 6),
              TextFieldWidget(
                txtController: ctrl.descriptionCtrl,
                hintText: ' Add Descriptions',
                maxLine: 5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Category',
                style: Appstyle.headingOne,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioWidget(
                      title: 'LRN',
                      categoryColor: Colors.green,
                      valueInput: 1,
                      groupValue: ctrl.selectedValue.value,
                      onChanged: (value) {
                        ctrl.setSelectedValue(value ?? 0);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      title: 'WRK',
                      categoryColor: Colors.blue.shade700,
                      valueInput: 2,
                      groupValue: ctrl.selectedValue.value,
                      onChanged: (value) {
                        ctrl.setSelectedValue(value ?? 0);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      title: 'GEN',
                      categoryColor: Colors.amberAccent.shade700,
                      valueInput: 3,
                      groupValue: ctrl.selectedValue.value,
                      onChanged: (value) {
                        ctrl.setSelectedValue(value ?? 0);
                      },
                    ),
                  ),
                ],
              ),
              //date and time Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimeWidget(
                    titleText: 'Date',
                    valueText:
                    DateFormat('dd/MM/yy').format(ctrl.selectedDate.value),
                    iconSection: Icons.calendar_today_outlined,
                    onTap: () => _selectDate(context, ctrl),
                  ),
                  const SizedBox(width: 22),
                  DateTimeWidget(
                    titleText: 'Time',
                    valueText:
                    '${ctrl.selectedTime.value.hour}:${ctrl.selectedTime.value.minute}',
                    iconSection: Icons.access_time_outlined,
                    onTap: () => _selectTime(context, ctrl),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.blue.shade800,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final category = _getCategory(ctrl.selectedValue.value);
                        if (ctrl.titleCtrl.text.isEmpty && ctrl.descriptionCtrl.text.isEmpty) {
                          Get.snackbar('Error', 'Please enter both title and description.', colorText: Colors.red);
                        } else if (ctrl.titleCtrl.text.isEmpty) {
                          Get.snackbar('Error', 'Please enter title.', colorText: Colors.red);
                        } else if (ctrl.descriptionCtrl.text.isEmpty) {
                          Get.snackbar('Error', 'Please enter description.', colorText: Colors.red);
                        } else {
                          ctrl.addTask(category);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectDate(BuildContext context, NewDataController ctrl) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ctrl.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      ctrl.setDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context, NewDataController ctrl) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
      ctrl.setSelectedTime(formattedTime);
    }
  }
}
