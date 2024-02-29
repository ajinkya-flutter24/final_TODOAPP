import 'package:flutter/material.dart';
import 'modelclass.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoList1 extends StatefulWidget {
  const TodoList1({super.key});
  @override
  State createState() => _TodoList1State();
}

class _TodoList1State extends State<TodoList1> {
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List cardColor = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  // model class :
  List<ToDoModelClass> todoList1 = [
    ToDoModelClass(
        title: "Take Task",
        description: "Take Notes of every app you Write",
        date: "10 July 202300,"),
    ToDoModelClass(
      title: "Arrange Meeting",
      description: "Meet the backend Team",
      date: "10 july 2023",
    )
  ];

  void showMyBottomSheet(bool doEdit, [ToDoModelClass? toDoModelObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        isDismissible: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Create New TO-DO",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  // style:,
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add To-Do Title',
                      // textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        label: Text('Title'),
                        hintText: "Add Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextField(
                      // controller: TextEditingController(text: "Description"),
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        // alignLabelWithHint: true,
                        label: Text("Description"),
                        hintText: "Add Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Date",
                        suffixIcon: const Icon(
                          Icons.date_range_rounded,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        String formatedDate =
                            DateFormat.yMMMd().format(pickedDate!);
                        setState(() {
                          dateController.text = formatedDate;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                    onPressed: () {
                      doEdit ? submit(doEdit, toDoModelObj) : submit(doEdit);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "SUBMIT",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }

// Submit :

  void submit(bool doEdit, [ToDoModelClass? toDoModelObj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          todoList1.add(
            ToDoModelClass(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim(),
            ),
          );
        });
      } else {
        setState(() {
          toDoModelObj!.date = dateController.text.trim();
          toDoModelObj.title = titleController.text.trim();
          toDoModelObj.description = descriptionController.text.trim();
        });
      }
    }
    clearController();
  }

// CLEAR CONTROLLER :
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

// REMOVE Notes
  void removeTasks(ToDoModelClass toDoModelObj) {
    setState(() {
      todoList1.remove(toDoModelObj);
    });
  }

  // Assign the TExt EDITING controller with the text values then open the bottom sheet
  void editTask(ToDoModelClass toDoModelObj) {
    titleController.text = toDoModelObj.title;
    descriptionController.text = toDoModelObj.description;
    dateController.text = toDoModelObj.date;
    showMyBottomSheet(true, toDoModelObj);
  }

  @override
//DISPOSE
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            clearController();
            showMyBottomSheet(false);
          },
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 255, 255),
          title: const Text(
            'To-Do List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: ListView.builder(
              itemCount: todoList1.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 112,
                  width: 330,
                  decoration: BoxDecoration(
                      color: cardColor[index % cardColor.length],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 4,
                            spreadRadius: 1,
                            color: Color.fromRGBO(58, 54, 54, 1))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            // padding: EdgeInsets.only(top: 123, left: 25),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 52,
                            width: 52,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.image),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todoList1[index].title,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  todoList1[index].description,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: const Color.fromRGBO(84, 84, 84, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 25, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              todoList1[index].date,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(132, 132, 132, 1),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    editTask(todoList1[index]);
                                  },
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Color.fromRGBO(0, 139, 148, 1),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    removeTasks(todoList1[index]);
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Color.fromRGBO(0, 139, 148, 1),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
