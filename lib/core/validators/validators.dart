class Validators {
  // Name validator
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Age validator
  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your age';
    }

    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Please enter a valid number';
    }

    if (age < 1 || age > 150) {
      return 'Please enter a valid age';
    }

    return null;
  }

  // Job validator
  static String? job(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your job';
    }
    if (value.trim().length < 2) {
      return 'Job must be at least 2 characters';
    }
    return null;
  }

  // Dropdown/Selection validator (for sex field)
  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  //task title validator
  static String? title(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  //task description validator
  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a description';
    }
    if (value.trim().length < 5) {
      return 'Description must be at least 5 characters';
    }
    return null;
  }

  //task taskGroup validator
  static String? taskGroup(int? value) {
    if (value == null) {
      return 'Please select a task group';
    }
    return null;
  }

  //task priority validator
  static String? priority(int? value) {
    if (value == null) {
      return 'Please select a priority';
    }
    if (value < 0 || value > 2) {
      return 'Invalid priority selected';
    }
    return null;
  }

  //task dueDate validator
  static String? dueDate(DateTime? value) {
    if (value != null && value.isBefore(DateTime.now())) {
      return 'Due date cannot be in the past';
    }
    return null;
  }
}
