import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/custom_webview.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/change_job_vehicle.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/utils/date_time_conversions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobFullDetails extends StatefulWidget {
  final JobModel jobModel;

  const JobFullDetails({Key? key, required this.jobModel}) : super(key: key);

  @override
  State<JobFullDetails> createState() => _JobFullDetailsState();
}

class _JobFullDetailsState extends State<JobFullDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsDetailsProvider>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   'Name :',
            //   style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.textDarTertiary),
            // ),
            // SizedBox(height: 8,),
            // Text(
            //   value.jobModel!.locationName!,
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            FAWidget(field: 'Location', answer: widget.jobModel.locationName!),
            const SizedBox(height: 8),
            FAWidget(field: 'Client', answer: widget.jobModel.clientName!),

            const SizedBox(height: 8),
            FAWidget(field: 'Code', answer: widget.jobModel.code!),
            const SizedBox(height: 8),
            if (widget.jobModel.ticketNo != null)
              FAWidget(field: 'Ticket NO', answer: widget.jobModel.ticketNo!),
            if (widget.jobModel.ticketNo != null)
              const SizedBox(height: 8),
            FAWidget(field: 'Status', answer: widget.jobModel.status!),
            const SizedBox(height: 8),

            if (widget.jobModel.openOn != null)
              FAWidget(
                field: 'Open On',
                answer: DateTimeConversion()
                    .convertToDateFormat(inputString: widget.jobModel.openOn!),
              ),
            if (widget.jobModel.assignedFor != null) const SizedBox(height: 8),
            if (widget.jobModel.assignedFor != null)
              FAWidget(
                field: 'Scheduled Date',
                answer: DateTimeConversion().convertToDateFormat(
                    inputString: widget.jobModel.assignedFor!),
              ),
            if (widget.jobModel.completedOn != null) const SizedBox(height: 8),
            if (widget.jobModel.completedOn != null)
              FAWidget(
                field: 'Completed On',
                answer: DateTimeConversion().convertToDateFormat(
                    inputString: widget.jobModel.completedOn!),
              ),
            if (widget.jobModel.closedOn != null) const SizedBox(height: 8),
            if (widget.jobModel.closedOn != null)
              FAWidget(
                field: 'Closed On',
                answer: DateTimeConversion().convertToDateFormat(
                    inputString: widget.jobModel.closedOn!),
              ),
            if (widget.jobModel.jobVehicles != null &&
                widget.jobModel.jobVehicles!.isNotEmpty)
              const SizedBox(height: 8),
            if (widget.jobModel.jobVehicles != null &&
                widget.jobModel.jobVehicles!.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Vehicle',
                      style: Theme.of(MyApp.navigatorKey.currentContext!)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '  :  ',
                    style: Theme.of(MyApp.navigatorKey.currentContext!)
                        .textTheme
                        .bodyMedium,
                  ),
                  Expanded(
                      flex: 7,
                      child: Wrap(
                        children: value.jobModel!.jobVehicles!
                            .map(
                              (e) => Row(
                                children: [
                                  Text(
                                    e.vehicleName!,
                                    style: Theme.of(
                                            MyApp.navigatorKey.currentContext!)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        changeJobVehicle(jobVehicle: e);
                                      },
                                      child: Image.asset(
                                        'assets/edit.png',
                                        height: 18,
                                        width: 18,
                                      )),
                                ],
                              ),
                            )
                            .toList(),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            if (widget.jobModel.assignedStaff != null)
              const SizedBox(height: 8),

            if (widget.jobModel.assignedStaff != null)
              FAWidget(field: 'Staffs', answer: widget.jobModel.assignedStaff!),
            if (widget.jobModel.description != null) const SizedBox(height: 8),

            if (widget.jobModel.description != null)
              FAWidget(
                  field: 'Description', answer: widget.jobModel.description!),
            if (widget.jobModel.comment != null) const SizedBox(height: 8),

            if (widget.jobModel.comment != null)
              FAWidget(field: 'Comments', answer: widget.jobModel.comment!),
            if (widget.jobModel.imageUrl != null) const SizedBox(height: 8),

            if (widget.jobModel.imageUrl != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'File',
                      style: Theme.of(MyApp.navigatorKey.currentContext!)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '  :  ',
                    style: Theme.of(MyApp.navigatorKey.currentContext!)
                        .textTheme
                        .bodyMedium,
                  ),
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => CustomWebView(
                        //             url: widget.jobModel.imageUrl!)));
                        _launchUrl(widget.jobModel.imageUrl!);
                      },
                      child: Text(
                        'Open File',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget FAWidget({required String field, required String answer}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$field ',
            style: Theme.of(MyApp.navigatorKey.currentContext!)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '  :  ',
          style:
              Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
        ),
        Expanded(
          flex: 7,
          child: Text(
            answer,
            style: Theme.of(MyApp.navigatorKey.currentContext!)
                .textTheme
                .bodyMedium,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
Future<void> _launchUrl(String _url) async {
  if (!await launchUrl(Uri.parse(_url),mode:LaunchMode.externalApplication )) {
    throw 'Could not launch $_url';
  }
}