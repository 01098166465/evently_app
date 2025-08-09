import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "/create-event";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  CategoryModel selectedCategory = CategoryModel.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat("dd/M/yyyy");
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
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
                        selectedForegroundColor: settingsProvider.isDark
                            ? AppTheme.black
                            : AppTheme.white,
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
                      hintText: "Event Title",
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
                      hintText: "Event Description",
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
                          colorFilter: ColorFilter.mode(
                            settingsProvider.isDark
                                ? AppTheme.white
                                : AppTheme.black,
                            BlendMode.srcIn,
                          ),
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
                          colorFilter: ColorFilter.mode(
                            settingsProvider.isDark
                                ? AppTheme.white
                                : AppTheme.black,
                            BlendMode.srcIn,
                          ),
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
                              initialTime: TimeOfDay.now(),
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
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primary),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/location.svg",
                              colorFilter: ColorFilter.mode(
                                settingsProvider.isDark
                                    ? AppTheme.black
                                    : AppTheme.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Cairo , Egypt ",
                                  style: textTheme.titleMedium!.copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    DefaultElevetedButton(
                      label: "Add Event",
                      onPressed: createEvent,
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

  void createEvent() {
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

      EventModel event = EventModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        category: selectedCategory,
        title: titleController.text,
        description: discriptionController.text,
        dateTime: dateTime,
      );

      FirebaseService.createEvent(event)
          .then((_) async {
            await Provider.of<EventsProvider>(
              context,
              listen: false,
            ).getEvents();

            Navigator.of(context).pop();
            UiUtils.showSuccessMessage("Event created successfully");
          })
          .catchError((_) {
            UiUtils.showErrorMessage("Failed to create event");
          });
    }
  }
}
