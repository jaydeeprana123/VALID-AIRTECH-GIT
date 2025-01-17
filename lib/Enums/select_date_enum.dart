enum SelectDateEnum {
  Past,

  Future,

  all


}


extension AstrologerListForEnumExtension on SelectDateEnum {
  int get outputVal {
    return [0, 1, 2][index];
  }
}