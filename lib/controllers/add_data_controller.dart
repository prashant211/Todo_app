import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/todo_model.dart';

class NewDataController extends GetxController {
  var selectedValue = 1.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;


  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference taskCollection;

  List<Task> tasks =[];
  
  void onInit() async{
    taskCollection = firestore.collection('task');
    await fetchTasks();
    super.onInit();
  }
  

  void setSelectedValue(int value) {
    selectedValue.value = value;
    update();
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    update();
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime.value = time;
    update();
  }

  addTask(String category){
    try {
      DocumentReference doc = taskCollection.doc();
      Task task =  Task(
            id: doc.id,
            title: titleCtrl.text,
            category: category,
            description: descriptionCtrl.text,
            date: _formatDate(selectedDate.value),
            time:_formatTime(selectedTime.value),
            isDone: false,
          );
      final taskJson = task.toJson();
      doc.set(taskJson);
      fetchTasks();
      Get.snackbar('Success','New Task has been added',colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(),colorText: Colors.red);
    }
  }

  fetchTasks() async{
    try{
      QuerySnapshot taskSnapshot = await taskCollection.get();
      final List<Task> retrieveTasks =
          taskSnapshot.docs.map(
                  (doc) => Task.fromJson(
            doc.data() as Map<String,dynamic>)
          ).toList();
      tasks.clear();
      tasks.assignAll(retrieveTasks);
    }catch (e){
      Get.snackbar('Error', e.toString(),colorText: Colors.red);
    }finally{
      update();
    }
}
  deleteTask(String id)async {
    try {
      await taskCollection.doc(id).delete();
      Get.snackbar('Deleted', 'Product Deleted ',colorText: Colors.red);
      fetchTasks();
    }catch(e){
      Get.snackbar('Error', e.toString(),colorText: Colors.red);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

  String _formatTime(TimeOfDay time) {
    final String hour = _twoDigits(time.hour);
    final String minute = _twoDigits(time.minute);
    return '$hour:$minute';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  setValuesDefault(){
    titleCtrl.clear();
    descriptionCtrl.clear();
    setSelectedValue(1);
    setDate(DateTime.now());
    setSelectedTime(TimeOfDay.now());
    update();
  }

}
