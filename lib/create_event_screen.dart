import 'package:evently/app_theme.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "/create-event";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
  int currentIndex = 0;
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  get currentIndex => null;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset(
                  "assets/images/meeting.png",

                  height: screenSize.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: CategoryModel.category.length,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.only(right: 10),
                padding: EdgeInsets.only(left: 16),

                tabs: [
                  ...CategoryModel.category
                      .map(
                        (category) => TabItem(
                          label: category.name,
                          icon: category.icon,
                          isSelected:
                              currentIndex ==
                              CategoryModel.category.indexOf(category),
                          selectedForegroundColor: AppTheme.white,
                          selectedBackgroundColor: AppTheme.primary,
                          unselectedForegroundColor: AppTheme.primary,
                        ),
                      )
                      .toList(),
                ],
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
                          },
                          child: Text(
                            "Choose Date",
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
                              initialTime: TimeOfDay.now(),
                            );
                          },
                          child: Text(
                            "Choose Time",
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
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
    if (formkey.currentState!.validate()) {}
  }
}
