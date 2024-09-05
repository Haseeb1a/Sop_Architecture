import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_sop/general/utils/appcolors.dart';

class ToastMessage {
  static void showMessage(String msg, dynamic color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: AppColors.dark,
        fontSize: 16.0
        );
  }
}