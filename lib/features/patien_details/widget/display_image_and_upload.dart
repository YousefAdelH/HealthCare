import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patien_details/widget/image_view_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class UploadImageAndDisplay extends StatelessWidget {
  const UploadImageAndDisplay({
    super.key,
    required this.con,
  });

  final PaientDetailsCtrl con;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => con.isLoading.value
            ? CircularProgressIndicator()
            : SizedBox(
                height: 200.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: con.itemobserval.value.images?.length ?? 0,
                  itemBuilder: (context, index) {
                    final image = con.itemobserval.value.images?[index];
                    return GestureDetector(
                      onTap: () =>
                          image != null ? OneImageViewer(context, image) : null,
                      child: Stack(
                        children: [
                          Container(
                            height: 130.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                              image: image != null
                                  ? DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: index < con.imageLoadingStates.length &&
                                    con.imageLoadingStates[index]
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox.shrink(),
                          ),
                          Positioned(
                              child: IconButton(
                            onPressed: () async {
                              await con.deleteImage(image!);
                              // Handle image deletion
                              // if (image != null) {
                              //   bool success = await con.deleteImage(
                              //       image); // Use controller's deleteImage method
                              //   if (success) {
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(SnackBar(
                              //       content:
                              //           Text('Image deleted successfully.'),
                              //     ));
                              //   } else {
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(SnackBar(
                              //       content: Text('Failed to delete image.'),
                              //     ));
                              //   }
                              // }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              )),
        con.isEdit.value
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.add_a_photo, size: 60.dm),
                  onPressed: () => con.uploadImage(),
                ),
              )
      ],
    );
  }
}
