import 'package:flutter/material.dart';
import 'package:task_manager_getx/widgets/snackbar_message.dart';
import '../Data/Models/network_response.dart';
import '../Data/Models/task_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import '../utils/appColor.dart';
import 'center_circular_progress_indicator.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskModel, required this.onRefreshLIst});

  final TaskModel taskModel;
  final VoidCallback onRefreshLIst;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInprogress = false;
  bool _deleteStatusInprogress = false;


  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description ?? ''),
            Text('Date ${widget.taskModel.createdDate ?? ''}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusSection(),
                Wrap(
                  children: [
                    Visibility(
                      visible: !_changeStatusInprogress,
                      replacement:CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: () {
                          _onTapEditButton();
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _onTapDeleteButton();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Chip _buildTaskStatusSection() {
    return Chip(
      label: Text(widget.taskModel.status!),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide(color: AppColor.themecolor),
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                ["New", "Completed", "Cancelled", "Progress"].map((e) {
                  return ListTile(
                    onTap: (){
                      _changeStatus(e);
                      Navigator.pop(context);
                    },
                    title: Text(e),
                    selected: _selectedStatus == e,
                    trailing: _selectedStatus == e ? Icon(Icons.check) : null,
                  );
                }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInprogress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateStatus(widget.taskModel.sId!, newStatus),
    );
    if (response.isSuccessful) {
      widget.onRefreshLIst();
    } else {
      _changeStatusInprogress=false;
      setState(() {
      });
      showSnackbarMessage(context, response.errorMessage);
    }
  }

  void _onTapDeleteButton() async{
    _deleteStatusInprogress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteStatus(widget.taskModel.sId!),
    );
    if (response.isSuccessful) {
      widget.onRefreshLIst();
    } else {
      _deleteStatusInprogress=false;
      setState(() {
      });
      showSnackbarMessage(context, response.errorMessage);
    }
  }
}
