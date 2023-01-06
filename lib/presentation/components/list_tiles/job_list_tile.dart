import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/utils/date_time_conversions.dart';

class JobListTile extends StatelessWidget {
  final JobModel jobModel;
  final showTrailingIcon;

  const JobListTile(
      {Key? key, required this.jobModel, this.showTrailingIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: .5,
      child: ListTile(
        tileColor: AppColors.tertiary,
        leading: Image.asset(
          jobModel.code!.substring(0, 1).toLowerCase() == 'p'
              ? 'assets/project_job.png'
              : 'assets/site_job.png',
          color: Colors.black,
          height: 62,
          width: 62,
        ),
        title: Text(jobModel.locationName!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobModel.clientName!,
              style:
                  Theme.of(context).textTheme.titleSmall!.copyWith(height: 1.5),
            ),
            Text(
              '${jobModel.code??''}, ${jobModel.ticketNo??''}' ,
              style:
              Theme.of(context).textTheme.titleSmall!.copyWith(height: 1.5),
            ),

            if (jobModel.openOn != null)
              Row(
                children: [
                  Text(
                    'Open On          : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                  Text(
                    DateTimeConversion()
                        .convertToDateFormat(inputString: jobModel.openOn!),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                ],
              ),
            if (jobModel.assignedFor != null && jobModel.status == 'Assigned')
              Row(
                children: [
                  Text(
                    'Scheduled Date : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                  Text(
                    DateTimeConversion().convertToDateFormat(
                        inputString: jobModel.assignedFor!,
                        inputFormat: 'yyyy-MM-dd'),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                ],
              ),
            if (jobModel.pendingOn != null && jobModel.status == 'Pending')
              Row(
                children: [
                  Text(
                    'Pending On : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                  Text(
                    DateTimeConversion().convertToDateFormat(
                        inputString: jobModel.pendingOn!,
                        inputFormat: 'yyyy-MM-dd'),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                ],
              ),
            if (jobModel.completedOn != null && jobModel.status == 'Completed')
              Row(
                children: [
                  Text(
                    'Completed On  : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                  Text(
                    DateTimeConversion().convertToDateFormat(
                        inputString: jobModel.completedOn!,
                        inputFormat: 'yyyy-MM-ddThh:mm:ss'),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                ],
              ),
            if (jobModel.closedOn != null && jobModel.status == 'Closed')
              Row(
                children: [
                  Text(
                    'Closed On       : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                  Text(
                    DateTimeConversion().convertToDateFormat(
                        inputString: jobModel.closedOn!,
                        inputFormat: 'yyyy-MM-ddThh:mm:ss'),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(height: 1.5),
                  ),
                ],
              ),
          ],
        ),
        // trailing: showTrailingIcon ? const Icon(Icons.arrow_forward_ios) : null,
      ),
    );
  }
}
