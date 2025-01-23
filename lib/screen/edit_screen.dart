import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../data/firestor.dart';
import '../model/notes_model.dart';
import 'package:intl/intl.dart'; // For date formatting

class Edit_Screen extends StatefulWidget {
  final Note note; // Use the correct variable name
  Edit_Screen(this.note, {super.key});

  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  TextEditingController? title;
  TextEditingController? subtitle;
  TextEditingController? selectedTime;

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int selectedImageIndex = 0;

  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.note.title);
    subtitle = TextEditingController(text: widget.note.subtitle);
    selectedDateTime = DateTime.tryParse(widget.note.time) ?? DateTime.now();
    selectedTime = TextEditingController(text: DateFormat('hh:mm a').format(selectedDateTime!));
    selectedImageIndex = widget.note.image; // Initialize with the current image index
  }

  @override
  void dispose() {
    title?.dispose();
    subtitle?.dispose();
    selectedTime?.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleWidget(),
              SizedBox(height: 20),
              subtitleWidget(),
              SizedBox(height: 20),
              timePicker(),
              SizedBox(height: 20),
              imageSelector(),
              SizedBox(height: 20),
              actionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_green,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            String formattedTime = DateFormat('HH:mm').format(selectedDateTime!);
            Firestore_Datasource().Update_Note(
              widget.note.id,
              selectedImageIndex,
              title!.text,
              subtitle!.text,
              formattedTime,
            );
            Navigator.pop(context);
          },
          child: Text('Update Task'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Widget timePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
          );
          if (time != null) {
            setState(() {
              selectedDateTime = DateTime(
                selectedDateTime!.year,
                selectedDateTime!.month,
                selectedDateTime!.day,
                time.hour,
                time.minute,
              );
              selectedTime = TextEditingController(text: DateFormat('hh:mm a').format(selectedDateTime!));
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  "${selectedTime!.text}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSelector() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 4, // Assuming there are 4 images to choose from
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedImageIndex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: selectedImageIndex == index ? custom_green : Colors.grey,
                  ),
                ),
                width: 140,
                margin: EdgeInsets.all(8),
                child: Image.asset('images/$index.png'),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Title',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget subtitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
