// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get addTask => 'Добавить задачу';

  @override
  String get addNote => 'Добавить заметку';

  @override
  String get tasks => 'Задачи';

  @override
  String get notes => 'Заметки';

  @override
  String get allTasks => 'Все задачи';

  @override
  String get allNotes => 'Все заметки';

  @override
  String get filterByDate => 'Фильтр по дате';

  @override
  String get all => 'Все';

  @override
  String get today => 'Сегодня';

  @override
  String get pickDate => 'Выбрать дату';

  @override
  String get filterByPriority => 'Фильтр по приоритету';

  @override
  String get high => 'Высокий';

  @override
  String get medium => 'Средний';

  @override
  String get low => 'Низкий';

  @override
  String get noTasksFound => 'Задачи не найдены';

  @override
  String get noTasksYet => 'Задач пока нет';

  @override
  String get retry => 'Повторить';

  @override
  String get taskUpdatedSuccessfully => 'Задача успешно обновлена!';

  @override
  String taskDeleted(String title, Object taskTitle) {
    return '\'$title\' удалена';
  }

  @override
  String get chooseTaskType => 'Выберите тип задачи';

  @override
  String get title => 'Заголовок';

  @override
  String get description => 'Описание';

  @override
  String get priorityLabel => 'Приоритет';

  @override
  String get dueDateLabel => 'Срок выполнения';

  @override
  String get noTaskGroups => 'Нет групп задач';

  @override
  String get saveTask => 'Сохранить задачу';

  @override
  String get newType => 'Новый тип';

  @override
  String get newTaskType => 'Новый тип задачи';

  @override
  String get nameLabel => 'Имя';

  @override
  String get color => 'Цвет';

  @override
  String get cancel => 'Отмена';

  @override
  String get create => 'Создать';

  @override
  String get pickADueDate => 'Выберите срок';

  @override
  String get done => 'Готово';

  @override
  String get titleHint => 'Заголовок';

  @override
  String get noteHint => 'Начните вводить...';

  @override
  String get searchNotes => 'Поиск заметок...';

  @override
  String get noNotesYet => 'Заметок пока нет';

  @override
  String get noResultsFound => 'Результаты не найдены';

  @override
  String get onboarding => 'Регистрация';

  @override
  String get tellUsAboutYourself => 'Расскажите о себе 😊';

  @override
  String get name => 'Имя';

  @override
  String get age => 'Возраст';

  @override
  String get sex => 'Пол';

  @override
  String get male => 'Мужчина';

  @override
  String get female => 'Женщина';

  @override
  String get other => 'Другое';

  @override
  String get pleaseSelectYourSex => 'Пожалуйста, выберите ваш пол';

  @override
  String get job => 'Работа';

  @override
  String get next => 'Далее';

  @override
  String get createYourPin => 'Создайте ваш PIN';

  @override
  String get confirmYourPin => 'Подтвердите ваш PIN';

  @override
  String get pinsDoNotMatch => 'PIN-коды не совпадают';

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
  String get language => 'Язык';

  @override
  String get validatorNameRequired => 'Имя обязательно';

  @override
  String get validatorNameMinLength => 'Имя должно быть не менее 2 символов';

  @override
  String get validatorAgeRequired => 'Возраст обязателен';

  @override
  String get validatorAgeInvalidNumber => 'Возраст должен быть числом';

  @override
  String get validatorAgeInvalid => 'Возраст должен быть от 1 до 150';

  @override
  String get validatorJobRequired => 'Работа обязательна';

  @override
  String get validatorJobMinLength => 'Работа должна быть не менее 2 символов';

  @override
  String get validatorSexRequired => 'Пол обязателен';

  @override
  String get validatorTitleRequired => 'Заголовок обязателен';

  @override
  String get validatorTitleMinLength =>
      'Заголовок должен быть не менее 3 символов';

  @override
  String get validatorDescriptionRequired => 'Описание обязательно';

  @override
  String get validatorDescriptionMinLength =>
      'Описание должно быть не менее 5 символов';

  @override
  String get validatorTaskGroupRequired => 'Пожалуйста, выберите группу задач';

  @override
  String get validatorPriorityRequired => 'Приоритет обязателен';

  @override
  String get validatorPriorityInvalid => 'Неверный приоритет';

  @override
  String get validatorDueDatePast => 'Срок не может быть в прошлом';
}
