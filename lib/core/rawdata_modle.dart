import 'package:todo_bloc/core/crud_enum.dart';

class RawData {
  final CrudStatus ? status;
  final dynamic data;
  RawData({this.data,this.status});
}

