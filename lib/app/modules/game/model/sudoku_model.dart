import 'dart:convert';

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




  @override
  bool operator ==(covariant SudokuModel other) {
    if (identical(this, other)) return true;

    return
      other.value == value ;

  }

  @override
  int get hashCode => value.hashCode ;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'isEditable': isEditable,
      'isValid': isValid,
    };
  }

  factory SudokuModel.fromMap(Map<String, dynamic> map) {
    return SudokuModel(
      value: map['value'] as int,
      isEditable: map['isEditable'] as bool,
      isValid: map['isValid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SudokuModel.fromJson(String source) => SudokuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
