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
}