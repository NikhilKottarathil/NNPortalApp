import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*.8,
      // backgroundColor: AppColors.primaryBase,

      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: AppColors.primaryBase,
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(14),
              child: Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: MediaQuery.of(context).size.width * .3,
                      // color: Colors.white,
                    ),
                    Text(
                      value.userModel!.staffName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          // .copyWith(color: Colors.white),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            // button(text: 'Vehicle history')
          ],
        ),
      ),
    );
  }
}



//
// Future<bool> addWorkLogs(
//     {required TimeOfDay checkInTime, required TimeOfDay checkOutTime}) async {
//   pageStatus = PageStatus.loading;
//   notifyListeners();
//
//   try {
//     var format = DateFormat('yyyy-MM-dd HH:mm:ss');
//     String checkInDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
//     String checkOutDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
//
//     Map<String, dynamic> requestBody = {
//       'jobId': 0,
//       'checkIn': checkInDateString,
//       'checkout': checkOutDateString,
//       'isMain': true
//     };
//     var response = await postDataRequest(
//         urlAddress: 'Staffs/PostStaffLog',
//         requestBody: requestBody,
//         isShowLoader: false);
//     getLogs();
//
//     pageStatus = PageStatus.loaded;
//     notifyListeners();
//     return true;
//   } catch (e) {
//     print(e);
//     pageStatus = PageStatus.failed;
//     notifyListeners();
//     return false;
//   }
// }
//
// Future<bool> updateWorkLogs(
//     {required TimeOfDay checkInTime,
//       required TimeOfDay checkOutTime,
//       required LogModel logModel}) async {
//   pageStatus = PageStatus.loading;
//   notifyListeners();
//
//   try {
//     var format = DateFormat('yyyy-MM-dd HH:mm:ss');
//     String checkInDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
//     String checkOutDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
//
//     Map<String, dynamic> requestBody = {
//       'jobId': 0,
//       'checkIn': checkInDateString,
//       'checkout': checkOutDateString,
//       'isMain': true
//     };
//     var response = await postDataRequest(
//         urlAddress: 'Staffs/PutStaffLog/${logModel.staffLogModel!.id}',
//         requestBody: requestBody,
//         method: 'put',
//         isShowLoader: false);
//     getLogs();
//
//     pageStatus = PageStatus.loaded;
//     notifyListeners();
//     return true;
//   } catch (e) {
//     print(e);
//     pageStatus = PageStatus.failed;
//     notifyListeners();
//     return false;
//   }
// }
//
// Future<bool> addVehicleLogs(
//     {required TimeOfDay checkInTime,
//       required TimeOfDay checkOutTime,
//       required String vehicleId,
//       required String jobId}) async {
//   pageStatus = PageStatus.loading;
//   notifyListeners();
//
//   try {
//     var format = DateFormat('yyyy-MM-dd HH:mm:ss');
//     String checkInDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
//     String checkOutDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
//
//     Map<String, dynamic> requestBody = {
//       'jobId': jobId,
//       'vehicleId': vehicleId,
//       'checkIn': checkInDateString,
//       'checkout': checkOutDateString,
//     };
//     var response = await postDataRequest(
//         urlAddress: 'Vehicles/PostVehicleLog',
//         requestBody: requestBody,
//         isShowLoader: false);
//     getLogs();
//
//     pageStatus = PageStatus.loaded;
//     notifyListeners();
//     return true;
//   } catch (e) {
//     print(e);
//     pageStatus = PageStatus.failed;
//     notifyListeners();
//     return false;
//   }
// }
//
// Future<bool> updateVehicleLogs(
//     {required TimeOfDay checkInTime,
//       required TimeOfDay checkOutTime,
//       required String vehicleId,
//       required String jobId,
//       required LogModel logModel}) async {
//   pageStatus = PageStatus.loading;
//   notifyListeners();
//
//   try {
//     var format = DateFormat('yyyy-MM-dd HH:mm:ss');
//     String checkInDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
//     String checkOutDateString = format.format(TimeUtils()
//         .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
//
//     Map<String, dynamic> requestBody = {
//       'jobId': jobId,
//       'vehicleId': vehicleId,
//       'checkIn': checkInDateString,
//       'checkout': checkOutDateString,
//     };
//     var response = await postDataRequest(
//         urlAddress: 'Vehicles/PutVehicleLog/${logModel.vehicleLogModel!.id}',
//         requestBody: requestBody,
//         method: 'put',
//         isShowLoader: false);
//     getLogs();
//
//     pageStatus = PageStatus.loaded;
//     notifyListeners();
//     return true;
//   } catch (e) {
//     print(e);
//     pageStatus = PageStatus.failed;
//     notifyListeners();
//     return false;
//   }
// }