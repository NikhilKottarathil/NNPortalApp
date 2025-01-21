import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/leave_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/providers/leave_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaveTile extends StatelessWidget {
  const LeaveTile({Key? key, required this.leaveModel}) : super(key: key);

  final LeaveModel leaveModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tertiary, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/check_in.png',
                        height: 21,
                        width: 21,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text('Leave From   :  ${leaveModel.leaveFrom}',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/check_out.png',
                        height: 21,
                        width: 21,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text('Leave Till       :  ${leaveModel.leaveTo}',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ],
              )),
              if (leaveModel.isApproved != null && leaveModel.isApproved!)
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.only(right: 13),
                  icon: Image.asset('assets/approved.png',height: 21,),
                  iconSize: 21,
                  onPressed: () {},
                ),
              if (leaveModel.isApproved == null || !leaveModel.isApproved!)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.only(right: 13),
                      icon: Image.asset('assets/edit.png'),
                      iconSize: 21,
                      onPressed: () {
                        Provider.of<LeaveProvider>(
                                MyApp.navigatorKey.currentContext!,
                                listen: false)
                            .selectLeaveTileForEdit(leaveModel.id!);
                      },
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      icon: Image.asset('assets/delete.png'),
                      iconSize: 21,
                      onPressed: () {
                        showCustomAlertDialog(
                            message: 'Are you sure to delete?',
                            negativeButtonText: 'Cancel',
                            positiveButtonText: 'CONFIRM',
                            positiveButtonAction: () {
                              Provider.of<LeaveProvider>(
                                      MyApp.navigatorKey.currentContext!,
                                      listen: false)
                                  .deleteLeaveData(leaveModel.id!);
                              Navigator.pop(context);
                            });
                      },
                    ),
                  ],
                )
            ],
          ),
          const Divider(),
          if (leaveModel.joiningDate != null)
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Date of Joining  : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: leaveModel.joiningDate,
                  ),
                ],
              ),
            ),
          if (leaveModel.isAnnualLeave != null)
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Annual Leave     : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: leaveModel.isAnnualLeave! ? 'Yes' : 'No',
                  ),
                ],
              ),
            ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Reason               : ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: leaveModel.reason??'',
                ),
              ],
            ),
          ),
          if (leaveModel.attachmentUrl != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attachment        :',
                  style: Theme.of(MyApp.navigatorKey.currentContext!)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(leaveModel.attachmentUrl!);
                  },
                  child: Text(
                    'Open File',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          if (leaveModel.note != null)
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Note             : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: leaveModel.note ?? 'No notes',
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String _url) async {
  if (!await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
