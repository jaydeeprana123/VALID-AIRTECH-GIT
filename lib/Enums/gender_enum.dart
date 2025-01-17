enum GenderEnum {
  Male,

  Female


}


extension GenderForEnumExtension on GenderEnum {
  int get outputVal {
    return [0, 1][index];
  }
}