// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  const UploadProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<UploadProfilePictureScreen> createState() =>
      _UploadProfilePictureScreenState();
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  final picker = ImagePicker();

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.updateUserImage(image: image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(38, 60, 38, 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: AppCustomColors.textBlue,
                        ),
                      ),
                      const SizedBox(width: 21),
                      Text(
                        'Upload my photo',
                        style: textStyle24Bold,
                      )
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      height: 190,
                    ),
                    Positioned(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        color: const Color(0XFFF2F2F2),
                        padding: const EdgeInsets.fromLTRB(38, 20, 38, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                'Your photo will be displayed shortly after upload',
                                textAlign: TextAlign.justify,
                                style: textStyle17w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      child: SizedBox(
                        child: state is UserLoading
                            ? const Center(
                                child: CircularLoadingWidget(),
                              )
                            : state is UserLoaded
                                ? Container(
                                    width: 175,
                                    height: 175,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: state.user.imagePath != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                state.user.imagePath!,
                                              ),
                                            )
                                          : null,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.user.name!.substring(0, 1),
                                      style: textStyle24Bold.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 90,
                      child: GestureDetector(
                        onTap: () {
                          selectImageSourceDialog();
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_outlined,
                            size: 20.0,
                            color: Color(0xFF404040),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 59),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DottedBorder(
                    strokeWidth: 3,
                    dashPattern: const [15, 20],
                    borderType: BorderType.Rect,
                    color: Colors.black.withOpacity(.36),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 48,
                            width: double.infinity,
                            color: const Color(0XFFF2F2F2),
                            child: Center(
                              child: Text(
                                'Uploading Rules',
                                style: textStyle15w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: Image.asset("assets/images/collage.png"),
                          ),
                          const SizedBox(height: 26),
                          bulletPoint(
                              'Please upload a photo that matches the gender, age and status details in your personal profile'),
                          const SizedBox(height: 15),
                          bulletPoint(
                              'Use a photo that is appropraite for a business setting. Group photos are not allowed.'),
                          const SizedBox(height: 15),
                          bulletPoint(
                              'Photos violating our rules will be removed without notice.'),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bulletPoint(String point) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.circle,
                size: 13,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                point,
                style: textStyle13w400,
              ),
            ),
          ],
        ),
      );

  selectImageSourceDialog() {
    showDialog(
      context: context,
      builder: (builder) => Align(
        alignment: Alignment.bottomCenter,
        child: Wrap(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      selectOrTakePhoto(ImageSource.camera);
                      // getImage(0);
                    },
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.camera_alt, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      selectOrTakePhoto(ImageSource.gallery);
                    },
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.photo_library_outlined, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
