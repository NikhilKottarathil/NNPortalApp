import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/presentation/components/custom_webview.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/permission_request_alert.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/shimmer_widget.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../constants/enums.dart';

class JobAttachments extends StatelessWidget {
  const JobAttachments({Key? key}) : super(key: key);

  final List<String> imageFormats = const ['jpg', 'png', 'raw', 'svg'];

  @override
  Widget build(BuildContext context) {
    double fileSize = MediaQuery.of(context).size.width * .15;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<JobsDetailsProvider>(builder: (context, value, child) {
        return value.pageStatus == PageStatus.loading ||
                value.pageStatus == PageStatus.initialState
            ? const CustomCircularProgressIndicator()
            : value.jobAttachmentModels.isEmpty
                ? const NoItemsFound()
                : ListView.separated(
                    // gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2, childAspectRatio: 3 / 4),
                    padding: const EdgeInsets.all(14),
                    itemCount: value.jobAttachmentModels.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print(value.jobAttachmentModels[index].uploadUrl!
                          .toString()
                          .substring(value.jobAttachmentModels[index].uploadUrl!
                                  .toString()
                                  .length -
                              3));

                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.tertiary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CustomWebView(
                                              url: value
                                                  .jobAttachmentModels[index]
                                                  .uploadUrl!,
                                            )));
                              },
                              child: imageFormats.contains(value
                                      .jobAttachmentModels[index].uploadUrl!
                                      .toString()
                                      .substring(value
                                              .jobAttachmentModels[index]
                                              .uploadUrl!
                                              .toString()
                                              .length -
                                          3))
                                  ? CachedNetworkImage(
                                      imageUrl: value.jobAttachmentModels[index]
                                          .uploadUrl!,
                                      imageBuilder: (context, imageProvider) =>
                                          ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Container(
                                          height: fileSize,
                                          width: fileSize,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              ShimmerRectangle(
                                                  height: fileSize,
                                                  width: fileSize),
                                      errorWidget: (_, url, error) =>
                                          Image.asset(
                                        'assets/file_icon.png',
                                        height: fileSize,
                                        width: fileSize,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/file_icon.png',
                                      height: fileSize,
                                      width: fileSize,
                                    ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date  :  ${value.jobAttachmentModels[index].uploadedOn!.substring(0, 10)}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Time  :  ${value.jobAttachmentModels[index].uploadedOn!.substring(10, value.jobAttachmentModels[index].uploadedOn!.length - 1)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      if(!Provider.of<AuthenticationProvider>(context, listen: false)
                                          .userModel!
                                          .onLeave!)
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        icon:  Image.asset('assets/delete.png'),
                                        iconSize: 21,
                                          onPressed: () {
                                            showCustomAlertDialog(
                                                message: 'Are you sure?',
                                                negativeButtonText: 'Cancel',
                                                positiveButtonText: 'CONFIRM',
                                                positiveButtonAction: () {
                                                  Provider.of<JobsDetailsProvider>(
                                                          MyApp.navigatorKey
                                                              .currentContext!,
                                                          listen: false)
                                                      .deleteAttachment(
                                                          jobAttachmentModel:
                                                              value.jobAttachmentModels[
                                                                  index]);
                                                  Navigator.pop(context);
                                                });
                                          },

                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                            // Row(
                            //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Flexible(
                            //       child: Text(
                            //         value.jobAttachmentModels[index]
                            //                 .uploadedOn ??
                            //             'Unknown date',
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .labelSmall,
                            //       ),
                            //     ),
                            //
                            //     IconButton(
                            //       constraints: BoxConstraints(),
                            //         padding: EdgeInsets.zero,
                            //         onPressed: () {
                            //           showCustomAlertDialog(message: 'Are you sure?',negativeButtonText: 'Cancel', positiveButtonText: 'CONFIRM', positiveButtonAction: (){
                            //             Provider.of<JobsDetailsProvider>(
                            //                 MyApp.navigatorKey.currentContext!,
                            //                 listen: false)
                            //                 .deleteAttachment(jobAttachmentModel: value.jobAttachmentModels[index]);
                            //             Navigator.pop(context);
                            //           });
                            //         },
                            //         icon: Icon(Icons.delete,color: AppColors.iconColor,))
                            //   ],
                            // ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
      }),
      floatingActionButton:!Provider.of<AuthenticationProvider>(context, listen: false)
          .userModel!
          .onLeave!? FloatingActionButton(
        backgroundColor: AppColors.secondaryBase,
        child: const Icon(Icons.attach_file),
        onPressed: () async {
          bool isGranted = await Permission.storage.request().isGranted;
          if (isGranted) {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: [
                'jpg',
                'png',
                'raw',
                'svg',
                'pdf',
                'doc',
                'docx',
                'xls',
                'xlsx',
                'ppt',
                'pptx',
                'txt',
                'html',
              ],
            );
            if (result != null) {
              File file = File(result.files.single.path!);
              Provider.of<JobsDetailsProvider>(
                      MyApp.navigatorKey.currentContext!,
                      listen: false)
                  .addAttachment(file);
            } else {
              // User canceled the picker
            }
          } else {
            await showStoragePermissionRequest();
          }
        },
      ):null,
    );
  }
}
