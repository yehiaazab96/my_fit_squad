class DropDownData<T> {
  String label;
  T? value;

  DropDownData({required this.label, required this.value});

  factory DropDownData.fromItem(dynamic item) {
    return DropDownData(value: item, label: item.name);
  }
}
