import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfileModel {
  final String name = '';
  final int score;

  // to store the available Hint
  final int availableHint;

  // to store the current level
  final int currentEasyLevel;
  final int currentMediumLevel;
  final int currentHardLevel;

  // to manage that is any level paused
  final bool isEasyLevelPause;
  final bool isMediumLevelPause;
  final bool isHardLevelPause;

  // to manage that Game Type is activeted or not
  final bool isMediumLevelActive;
  final bool isHardLevelActive;

  ProfileModel({
    required this.score,
    required this.availableHint,
    required this.currentEasyLevel,
    required this.currentMediumLevel,
    required this.currentHardLevel,
    required this.isEasyLevelPause,
    required this.isMediumLevelPause,
    required this.isHardLevelPause,
    required this.isMediumLevelActive,
    required this.isHardLevelActive,
  });

  ProfileModel copyWith({
    int? score,
    int? availableHint,
    int? currentEasyLevel,
    int? currentMediumLevel,
    int? currentHardLevel,
    bool? isEasyLevelPause,
    bool? isMediumLevelPause,
    bool? isHardLevelPause,
    bool? isMediumLevelActive,
    bool? isHardLevelActive,
  }) {
    return ProfileModel(
      score: score ?? this.score,
      availableHint: availableHint ?? this.availableHint,
      currentEasyLevel: currentEasyLevel ?? this.currentEasyLevel,
      currentMediumLevel: currentMediumLevel ?? this.currentMediumLevel,
      currentHardLevel: currentHardLevel ?? this.currentHardLevel,
      isEasyLevelPause: isEasyLevelPause ?? this.isEasyLevelPause,
      isMediumLevelPause: isMediumLevelPause ?? this.isMediumLevelPause,
      isHardLevelPause: isHardLevelPause ?? this.isHardLevelPause,
      isMediumLevelActive: isMediumLevelActive ?? this.isMediumLevelActive,
      isHardLevelActive: isHardLevelActive ?? this.isHardLevelActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'availableHint': availableHint,
      'currentEasyLevel': currentEasyLevel,
      'currentMediumLevel': currentMediumLevel,
      'currentHardLevel': currentHardLevel,
      'isEasyLevelPause': isEasyLevelPause,
      'isMediumLevelPause': isMediumLevelPause,
      'isHardLevelPause': isHardLevelPause,
      'isMediumLevelActive': isMediumLevelActive,
      'isHardLevelActive': isHardLevelActive,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      score: map['score'] as int,
      availableHint: map['availableHint'] as int,
      currentEasyLevel: map['currentEasyLevel'] as int,
      currentMediumLevel: map['currentMediumLevel'] as int,
      currentHardLevel: map['currentHardLevel'] as int,
      isEasyLevelPause: map['isEasyLevelPause'] as bool,
      isMediumLevelPause: map['isMediumLevelPause'] as bool,
      isHardLevelPause: map['isHardLevelPause'] as bool,
      isMediumLevelActive: map['isMediumLevelActive'] as bool,
      isHardLevelActive: map['isHardLevelActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(score: $score, availableHint: $availableHint, currentEasyLevel: $currentEasyLevel, currentMediumLevel: $currentMediumLevel, currentHardLevel: $currentHardLevel, isEasyLevelPause: $isEasyLevelPause, isMediumLevelPause: $isMediumLevelPause, isHardLevelPause: $isHardLevelPause, isMediumLevelActive: $isMediumLevelActive, isHardLevelActive: $isHardLevelActive)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return
      other.score == score &&
      other.availableHint == availableHint &&
      other.currentEasyLevel == currentEasyLevel &&
      other.currentMediumLevel == currentMediumLevel &&
      other.currentHardLevel == currentHardLevel &&
      other.isEasyLevelPause == isEasyLevelPause &&
      other.isMediumLevelPause == isMediumLevelPause &&
      other.isHardLevelPause == isHardLevelPause &&
      other.isMediumLevelActive == isMediumLevelActive &&
      other.isHardLevelActive == isHardLevelActive;
  }

  @override
  int get hashCode {
    return score.hashCode ^
      availableHint.hashCode ^
      currentEasyLevel.hashCode ^
      currentMediumLevel.hashCode ^
      currentHardLevel.hashCode ^
      isEasyLevelPause.hashCode ^
      isMediumLevelPause.hashCode ^
      isHardLevelPause.hashCode ^
      isMediumLevelActive.hashCode ^
      isHardLevelActive.hashCode;
  }
}
