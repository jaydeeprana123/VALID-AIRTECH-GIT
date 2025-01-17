enum UserTypeEnum {
  Admin,

  Employee,

  Customer


}


extension UserTypeForEnumExtension on UserTypeEnum {
  int get outputVal {
    return [0, 1, 2][index];
  }
}