import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:provider/provider.dart';

class LogTile extends StatefulWidget {
  final LogModel logModel;
  final bool isTimeVisible;
  final Function? deleteAction;
  final bool isFromInHand;

  const LogTile(
      {Key? key,
      required this.logModel,
      this.isTimeVisible = true,
      this.isFromInHand = false,
      this.deleteAction})
      : super(key: key);

  @override
  State<LogTile> createState() => _LogTileState();
}

class _LogTileState extends State<LogTile> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.logModel.logType == LogType.workLog
                          ? 'assets/work_log.png'
                          : widget.logModel.logType == LogType.siteLog
                              ? 'assets/site_log.png'
                              : widget.logModel.logType == LogType.vehicleLog
                                  ? 'assets/vehicle_log.png'
                                  : 'assets/tool_log.png',
                      height: 62,
                      width: 62,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isFromInHand)
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
                                child: Text(
                                    'Date         :  ${widget.isTimeVisible ? DateFormat('dd-MM-yyyy').format(widget.logModel.checkIn) : ''}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ],
                          ),
                        if (widget.isFromInHand)
                          const SizedBox(
                            height: 4,
                          ),
                        if (widget.isFromInHand)
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
                                child: Text(
                                    'Check In   :  ${widget.isTimeVisible ? DateFormat('hh:mm a').format(widget.logModel.checkIn) : ''}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ],
                          ),
                        if (!widget.isFromInHand)
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
                                child: Text(
                                    'Check In    :  ${widget.isTimeVisible ? DateFormat('hh:mm a').format(widget.logModel.checkIn) : ''}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ],
                          ),
                        if (!widget.isFromInHand)
                          const SizedBox(
                            height: 4,
                          ),
                        if (!widget.isFromInHand)
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
                                child: Text(
                                    'Check Out :  ${(widget.logModel.checkOut != null && widget.logModel.checkOut != '') ? DateFormat('hh:mm a').format(widget.logModel.checkOut!) : ''}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ],
                          ),
                      ],
                    )),
                  ],
                ),
              ),
              if (widget.deleteAction != null)
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.only(right: 0),
                  icon: Image.asset('assets/delete.png',height: 21,),
                  iconSize: 21,
                  onPressed: () {
                    showCustomAlertDialog(
                        message: 'Are you sure to delete?',
                        negativeButtonText: 'Cancel',
                        positiveButtonText: 'CONFIRM',
                        positiveButtonAction: () {
                          widget.deleteAction!();
                          Navigator.pop(context);
                        });
                  },
                ),
            ],
          ),
          if (widget.logModel.logType != LogType.workLog ||
              (widget.logModel.logType == LogType.workLog &&
                  (widget.logModel.staffLogModel!.isDailyLog ?? false)))
            const Divider(),
          if (widget.logModel.logType == LogType.workLog &&
              (widget.logModel.staffLogModel!.isDailyLog ?? false))
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Comment     : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: widget.logModel.staffLogModel!.comment ?? '',
                  ),
                ],
              ),
            ),
          if (widget.logModel.logType == LogType.vehicleLog)
            Row(
              children: [
                Image.asset(
                  'assets/vehicle_icon.png',
                  height: 21,
                  width: 21,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.logModel.vehicleLogModel!.vehicleNo!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (widget.logModel.logType == LogType.toolLog)
            Row(
              children: [
                Image.asset(
                  'assets/tool_icon.png',
                  height: 21,
                  width: 21,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.logModel.toolLogModel!.toolName!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (widget.logModel.logType == LogType.toolLog ||
              widget.logModel.logType == LogType.vehicleLog)
            SizedBox(
              height: 6,
            ),
          if (widget.logModel.logType != LogType.workLog)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/site_icon.png',
                  height: 21,
                  width: 21,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.logModel.locationName!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        widget.logModel.clientName!,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ],
            ),
          if (widget.isFromInHand && widget.logModel.staffName != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/project_job.png',
                  color: Colors.black,
                  height: 21,
                  width: 21,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    widget.logModel.staffName ?? 'Unknown user',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
