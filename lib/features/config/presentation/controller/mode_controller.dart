class ModeController {
  static String currentSelection = 'Claro';
  static List<String> options = ['Claro', 'Oscuro', 'Sistema'];

  static String getCurrentSelection() {
    return currentSelection;
  }

  static List<String> getOptions() {
    return options;
  }

  static void selectOption(String option) {
    if (options.contains(option)) {
      updateSelection(option);
    }
  }

  static void toggleOption(String option) {
    if (options.contains(option)) {
      updateSelection(option);
    }
  }

  static void resetToDefault() {
    updateSelection('Claro');
  }

  static void updateSelection(String newSelection) {
    currentSelection = newSelection;
    // Aquí puedes agregar lógica adicional, como guardar la selección en preferencias o actualizar la UI
  }
}
