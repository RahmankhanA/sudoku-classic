// ignore_for_file: public_member_api_docs, sort_constructors_first
class SudokuModel {
   int value;
   bool isEditable;
   bool isValid;
  SudokuModel({
    required this.value,
     this.isEditable=false,
     this.isValid=true,
  });



  SudokuModel copyWith({
    int? value,
    bool? isEditable,
    bool? isValid,
  }) {
    return SudokuModel(
      value: value ?? this.value,
      isEditable: isEditable ?? this.isEditable,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  String toString() => 'SudokuModel(value: $value, isEditable: $isEditable, isValid: $isValid)';



}
