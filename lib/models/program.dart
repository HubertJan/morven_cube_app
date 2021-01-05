class Program {
  final List<String> _instructions = [];

  String getInstructionsAsString() {
    String instructions = "";
    this._instructions.forEach((ins) => instructions += ins);
    return instructions;
  }
}
