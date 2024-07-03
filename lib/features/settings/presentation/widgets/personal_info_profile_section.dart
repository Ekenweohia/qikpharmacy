import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/edit_information_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/upload_profile_picture_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PersonalInfoProfileSection extends StatelessWidget {
  const PersonalInfoProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 15, 28, 0),
            child: Text(
              "User Profile",
              style: textStyle17w400,
            ),
          ),
          Divider(color: Colors.black.withOpacity(.2)),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upload Profile Picture",
                      style: textStyle15w400,
                    ),
                    InkWell(
                      onTap: () {
                        QikPharmaNavigator.push(
                          context,
                          const UploadProfilePictureScreen(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit general profile",
                      style: textStyle15w400,
                    ),
                    InkWell(
                      onTap: () {
                        QikPharmaNavigator.push(
                          context,
                          const EditInformationScreen(
                            fromHome: false,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
