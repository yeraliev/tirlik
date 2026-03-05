// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get addTask => 'Тапсырма қосу';

  @override
  String get addNote => 'Жазба қосу';

  @override
  String get tasks => 'Тапсырмалар';

  @override
  String get notes => 'Жазбалар';

  @override
  String get allTasks => 'Барлық тапсырмалар';

  @override
  String get allNotes => 'Барлық жазбалар';

  @override
  String get filterByDate => 'Күні бойынша сүзу';

  @override
  String get all => 'Барлығы';

  @override
  String get today => 'Бүгін';

  @override
  String get pickDate => 'Күн таңдау';

  @override
  String get filterByPriority => 'Басымдық бойынша сүзу';

  @override
  String get high => 'Жоғары';

  @override
  String get medium => 'Орташа';

  @override
  String get low => 'Төмен';

  @override
  String get noTasksFound => 'Тапсырмалар табылмады';

  @override
  String get noTasksYet => 'Тапсырмалар жоқ';

  @override
  String get retry => 'Қайталау';

  @override
  String get taskUpdatedSuccessfully => 'Тапсырма сәтті жаңартылды!';

  @override
  String taskDeleted(String title, Object taskTitle) {
    return '$taskTitle жойылды';
  }

  @override
  String get chooseTaskType => 'Тапсырма түрін таңдаңыз:';

  @override
  String get title => 'Тақырып';

  @override
  String get description => 'Сипаттама';

  @override
  String get priorityLabel => 'Басымдық:';

  @override
  String get dueDateLabel => 'Мерзімі (міндетті емес):';

  @override
  String get noTaskGroups => 'Тапсырма топтары жоқ';

  @override
  String get saveTask => 'Тапсырманы сақтау';

  @override
  String get newType => 'Жаңа түр';

  @override
  String get newTaskType => 'Жаңа тапсырма түрі';

  @override
  String get nameLabel => 'Атауы';

  @override
  String get color => 'Түс';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get create => 'Жасау';

  @override
  String get pickADueDate => 'Мерзімді таңдаңыз';

  @override
  String get done => 'Дайын';

  @override
  String get titleHint => 'Тақырып';

  @override
  String get noteHint => 'Жазба';

  @override
  String get searchNotes => 'Жазбаларды іздеу...';

  @override
  String get noNotesYet => 'Жазбалар жоқ';

  @override
  String get noResultsFound => 'Нәтижелер табылмады';

  @override
  String get onboarding => 'Тіркелу';

  @override
  String get tellUsAboutYourself => 'Өзіңіз туралы айтыңыз 😊';

  @override
  String get name => 'Аты';

  @override
  String get age => 'Жасы';

  @override
  String get sex => 'Жынысы';

  @override
  String get male => 'Еркек';

  @override
  String get female => 'Әйел';

  @override
  String get other => 'Басқа';

  @override
  String get pleaseSelectYourSex => 'Please select your sex';

  @override
  String get job => 'Мамандығы';

  @override
  String get next => 'Келесі';

  @override
  String get createYourPin => 'PIN-кодыңызды жасаңыз';

  @override
  String get confirmYourPin => 'PIN-кодыңызды растаңыз';

  @override
  String get pinsDoNotMatch => 'PIN-кодтар сәйкес келмейді';

  @override
  String welcomeBack(String name) {
    return 'Қош келдіңіз, $name!';
  }

  @override
  String get enterYourPin => 'PIN-кодты енгізіңіз';

  @override
  String get editTask => 'Тапсырманы өзгерту';

  @override
  String get taskTitleLabel => 'Тапсырма тақырыбы';

  @override
  String get enterTaskTitle => 'Тапсырма тақырыбын енгізіңіз';

  @override
  String get enterTaskDescription => 'Тапсырма сипаттамасын енгізіңіз';

  @override
  String get update => 'Жаңарту';

  @override
  String get deleteTaskTitle => 'Тапсырманы жою?';

  @override
  String deleteConfirmation(String taskTitle) {
    return '\"$taskTitle\" тапсырмасын жойғыңыз келетініне сенімдісіз бе?';
  }

  @override
  String get delete => 'Жою';

  @override
  String get language => 'Тіл';

  @override
  String get validatorNameRequired => 'Атыңызды енгізіңіз';

  @override
  String get validatorNameMinLength => 'Атыңыз кемінде 2 таңбадан тұруы керек';

  @override
  String get validatorAgeRequired => 'Жасыңызды енгізіңіз';

  @override
  String get validatorAgeInvalidNumber => 'Жарамды санды енгізіңіз';

  @override
  String get validatorAgeInvalid => 'Жарамды жасты енгізіңіз';

  @override
  String get validatorJobRequired => 'Мамандығыңызды енгізіңіз';

  @override
  String get validatorJobMinLength =>
      'Мамандығыңыз кемінде 2 таңбадан тұруы керек';

  @override
  String get validatorSexRequired => 'Жынысыңызды таңдаңыз';

  @override
  String get validatorTitleRequired => 'Тақырыпты енгізіңіз';

  @override
  String get validatorTitleMinLength =>
      'Тақырып кемінде 3 таңбадан тұруы керек';

  @override
  String get validatorDescriptionRequired => 'Сипаттаманы енгізіңіз';

  @override
  String get validatorDescriptionMinLength =>
      'Сипаттама кемінде 5 таңбадан тұруы керек';

  @override
  String get validatorTaskGroupRequired => 'Тапсырма тобын таңдаңыз';

  @override
  String get validatorPriorityRequired => 'Басымдықты таңдаңыз';

  @override
  String get validatorPriorityInvalid => 'Жарамсыз басымдық таңдалды';

  @override
  String get validatorDueDatePast => 'Мерзімі өткен уақытта болуы мүмкін емес';
}
