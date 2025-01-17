enum OrderStatusEnum { Pending, Completed, Cancelled, All }

extension OrderStatusEnumExtension on OrderStatusEnum {
  int get outputVal {
    return [0, 1, 2, 3][index];
  }
}
