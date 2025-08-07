import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:evently/providers/events_provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = "/edit_screen";

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late EventModel event;

  CategoryModel selectedCategory = CategoryModel.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat("dd/M/yyyy");
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      event = ModalRoute.of(context)!.settings.arguments as EventModel;

      final index = CategoryModel.categories.indexWhere(
        (cat) => cat.name == event.category.name,
      );

      if (index != -1) {
        setState(() {
          currentIndex = index;
          selectedCategory = CategoryModel.categories[index];
          titleController.text = event.title;
          discriptionController.text = event.description;
          selectedDate = event.dateTime;
          selectedTime = TimeOfDay.fromDateTime(event.dateTime);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/${selectedCategory.imageName}.png",
                  height: screenSize.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: CategoryModel.categories.length,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.only(right: 10),
                padding: EdgeInsets.only(left: 16),
                tabs: CategoryModel.categories
                    .map(
                      (category) => TabItem(
                        label: category.name,
                        icon: category.icon,
                        isSelected:
                            currentIndex ==
                            CategoryModel.categories.indexOf(category),
                        selectedForegroundColor: AppTheme.white,
                        selectedBackgroundColor: AppTheme.primary,
                        unselectedForegroundColor: AppTheme.primary,
                      ),
                    )
                    .toList(),
                onTap: (index) {
                  if (currentIndex == index) return;
                  currentIndex = index;
                  selectedCategory = CategoryModel.categories[currentIndex];
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title", style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: "Enter title",
                      prefixIconImageName: "title",
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text("Description", style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: "Enter description",
                      controller: discriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/date.svg",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 10),
                        Text("Event Date", style: textTheme.titleMedium),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                              initialDate: selectedDate ?? DateTime.now(),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? "Choose Date"
                                : dateFormat.format(selectedDate!),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/time.svg",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 10),
                        Text("Event Time", style: textTheme.titleMedium),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                            );
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedTime == null
                                ? "Choose Time"
                                : selectedTime!.format(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DefaultElevetedButton(
                      label: "Update Event",
                      onPressed: updateEvent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateEvent() async {
    if (formkey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      EventModel updatedEvent = EventModel(
        id: event.id,
        userId: event.userId,
        category: selectedCategory,
        title: titleController.text,
        description: discriptionController.text,
        dateTime: dateTime,
      );

      try {
        await FirebaseService.updateEvent(updatedEvent);

        final provider = Provider.of<EventsProvider>(context, listen: false);
        await provider.getEvents();

        UiUtils.showSuccessMessage("Event updated successfully");

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (e) {
        UiUtils.showErrorMessage("Failed to update event");
      }
    }
  }
}
