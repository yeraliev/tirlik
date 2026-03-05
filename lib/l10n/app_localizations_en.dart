// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addTask => 'Add Task';

  @override
  String get addNote => 'Add Note';

  @override
  String get tasks => 'Tasks';

  @override
  String get notes => 'Notes';

  @override
  String get allTasks => 'All Tasks';

  @override
  String get allNotes => 'All Notes';

  @override
  String get filterByDate => 'Filter by date';

  @override
  String get all => 'All';

  @override
  String get today => 'Today';

  @override
  String get pickDate => 'Pick date';

  @override
  String get filterByPriority => 'Filter by priority';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String get noTasksFound => 'No tasks found';

  @override
  String get noTasksYet => 'No tasks yet';

  @override
  String get retry => 'Retry';

  @override
  String get taskUpdatedSuccessfully => 'Task updated successfully!';

  @override
  String taskDeleted(String title, Object taskTitle) {
    return '\'$title\' deleted';
  }

  @override
  String get chooseTaskType => 'Choose your task type:';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get dueDateLabel => 'Due Date';

  @override
  String get noTaskGroups => 'No task groups';

  @override
  String get saveTask => 'Save Task';

  @override
  String get newType => 'New Type';

  @override
  String get newTaskType => 'New Task Type';

  @override
  String get nameLabel => 'Name';

  @override
  String get color => 'Color';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get pickADueDate => 'Pick a due date';

  @override
  String get done => 'Done';

  @override
  String get titleHint => 'Title';

  @override
  String get noteHint => 'Start typing...';

  @override
  String get searchNotes => 'Search notes...';

  @override
  String get noNotesYet => 'No notes yet';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get onboarding => 'Onboarding';

  @override
  String get tellUsAboutYourself => 'Tell us about yourself 😊';

  @override
  String get name => 'Name';

  @override
  String get age => 'Age';

  @override
  String get sex => 'Sex';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get pleaseSelectYourSex => 'Please select your sex';

  @override
  String get job => 'Job';

  @override
  String get next => 'Next';

  @override
  String get createYourPin => 'Create Your PIN';

  @override
  String get confirmYourPin => 'Confirm Your PIN';

  @override
  String get pinsDoNotMatch => 'PINs do not match';

  @override
  String welcomeBack(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get enterYourPin => 'Enter Your PIN';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskTitleLabel => 'Task Title';

  @override
  String get enterTaskTitle => 'Enter task title';

  @override
  String get enterTaskDescription => 'Enter task description';

  @override
  String get update => 'Update';

  @override
  String get deleteTaskTitle => 'Delete Task?';

  @override
  String deleteConfirmation(String taskTitle) {
    return 'Are you sure you want to delete \"$taskTitle\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get language => 'Language';

  @override
  String get validatorNameRequired => 'Name is required';

  @override
  String get validatorNameMinLength => 'Name must be at least 2 characters';

  @override
  String get validatorAgeRequired => 'Age is required';

  @override
  String get validatorAgeInvalidNumber => 'Age must be a valid number';

  @override
  String get validatorAgeInvalid => 'Age must be between 1 and 150';

  @override
  String get validatorJobRequired => 'Job is required';

  @override
  String get validatorJobMinLength => 'Job must be at least 2 characters';

  @override
  String get validatorSexRequired => 'Sex is required';

  @override
  String get validatorTitleRequired => 'Title is required';

  @override
  String get validatorTitleMinLength => 'Title must be at least 3 characters';

  @override
  String get validatorDescriptionRequired => 'Description is required';

  @override
  String get validatorDescriptionMinLength =>
      'Description must be at least 5 characters';

  @override
  String get validatorTaskGroupRequired => 'Please select a task group';

  @override
  String get validatorPriorityRequired => 'Priority is required';

  @override
  String get validatorPriorityInvalid => 'Invalid priority';

  @override
  String get validatorDueDatePast => 'Due date cannot be in the past';
}
