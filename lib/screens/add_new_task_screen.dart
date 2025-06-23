import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const String name='/addnewtaskscreen';
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();
  final GlobalKey<FormState> _addTaskFormKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
       Navigator.pop(context,_shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _addTaskFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Add New Task",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a value';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 5,
                      decoration: InputDecoration(hintText: "Description"),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter a value';
                        } else {
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: !_addNewTaskInProgress,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapSubmitButton();
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_addTaskFormKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);
    _addNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccessful) {
      _shouldRefreshPreviousPage = true;
      _clearTextField();
      showSnackbarMessage(context, "New Task Added");
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
