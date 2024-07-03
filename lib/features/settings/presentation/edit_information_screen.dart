// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/change_email/change_email_account_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/shared/extensions/string_extension.dart';

class EditInformationScreen extends StatefulWidget {
  final bool fromHome;
  const EditInformationScreen({
    Key? key,
    this.fromHome = true,
  }) : super(key: key);

  @override
  State<EditInformationScreen> createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  final List<String> _genders = ["Male", "Female"];
  String? _selectedGender;

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final picker = ImagePicker();

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.updateUserImage(image: image);
  }

  @override
  void initState() {
    super.initState();

    _getUserDetails();
  }

  void _getUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getUserDetails();
  }

  bool buttonEnabled() =>
      addressController.text.isNotEmpty &&
      cityController.text.isNotEmpty &&
      countryController.text.isNotEmpty &&
      zipCodeController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      _selectedGender != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _selectedGender =
                    state.user.gender == null || state.user.gender!.isEmpty
                        ? _genders[0]
                        : state.user.gender;

                addressController =
                    TextEditingController(text: state.user.address);

                cityController = TextEditingController(text: state.user.state);
                countryController =
                    TextEditingController(text: state.user.country);
                zipCodeController =
                    TextEditingController(text: state.user.zipCode);

                phoneNumberController =
                    TextEditingController(text: state.user.phoneNumber);
              });
            });
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularLoadingWidget(),
            );
          }
          if (state is UserLoaded) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      height: 270,
                    ),
                    Positioned(
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        color: const Color(0XFFF2F2F2),
                        padding: const EdgeInsets.fromLTRB(38, 0, 38, 0),
                        child: Row(
                          children: [
                            if (!widget.fromHome)
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
                              'Edit information',
                              style: textStyle24Bold,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: buttonEnabled()
                                  ? () async {
                                      final cubit =
                                          BlocProvider.of<UserCubit>(context);

                                      await cubit.updateUserDetails(
                                        gender: _selectedGender,
                                        country: countryController.text,
                                        state: cityController.text,
                                        address: addressController.text,
                                        zipCode: zipCodeController.text,
                                        phoneNumber:
                                            '${countryCodeController.text}${phoneNumberController.text}',
                                      );
                                    }
                                  : null,
                              child: Text(
                                'Save',
                                style: textStyle20Bold.copyWith(
                                    color: buttonEnabled()
                                        ? AppCustomColors.primaryColor
                                        : AppCustomColors.lightGray),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      child: SizedBox(
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: state is UserLoading
                              ? const Center(
                                  child: CircularLoadingWidget(),
                                )
                              : state.user.imagePath == null
                                  ? Text(
                                      state.user.name!.substring(0, 1),
                                      style: textStyle24Bold.copyWith(
                                        color: Colors.black,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 75,
                                      backgroundImage:
                                          NetworkImage(state.user.imagePath!),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            selectImageSourceDialog();
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 15.0,
                                            child: Icon(
                                              Icons.image_outlined,
                                              size: 20.0,
                                              color: Color(0xFF404040),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 36,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 13),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(.05),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account",
                                  style: textStyle20.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "${state.user.role?.name?.capitalize ?? 'User'} Account",
                                  style: textStyle13w400.copyWith(
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 19),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gender",
                                style: textStyle20.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.edit,
                                color: AppCustomColors.lightTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          DropdownButton(
                            hint: Text(
                              "Choose gender",
                              style: textStyle13w400.copyWith(
                                color: Colors.black.withOpacity(.4),
                              ),
                            ),
                            isExpanded: true,
                            items: _genders
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(
                                        gender,
                                        style: textStyle13w400.copyWith(
                                          color: Colors.black.withOpacity(.4),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(.05),
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Email Address",
                                      style: textStyle20.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () => QikPharmaNavigator.push(
                                        context,
                                        const ChangeAccountEmailScreen(),
                                      ),
                                      child: Text(
                                        "Change",
                                        style: textStyle12.copyWith(
                                          color: AppCustomColors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.edit,
                                      color: AppCustomColors.lightTextColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.user.email!,
                                        style: textStyle13w400.copyWith(
                                          color: Colors.black.withOpacity(.4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    state.user.isConfirmed == true
                                        ? Text(
                                            "Email Confirmed",
                                            style: textStyle12.copyWith(
                                              color:
                                                  AppCustomColors.primaryColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        : Text(
                                            "Not Confirmed",
                                            style: textStyle12.copyWith(
                                              color: AppCustomColors.red,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 19),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(.05),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Member ID",
                                  style: textStyle20.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Text(
                                  state.user.referralCode!.toUpperCase(),
                                  style: textStyle13w400.copyWith(
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 19),
                          Row(
                            children: [
                              Text(
                                "Contact Address",
                                style: textStyle20.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "*",
                                style: textStyle20BoldRed,
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          InputField(
                            hint: 'Street Address',
                            controller: addressController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            hint: 'City',
                            controller: cityController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            hint: 'Country/Region',
                            controller: countryController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 19),
                          Row(
                            children: [
                              Text(
                                "Zip/Postal Code",
                                style: textStyle20.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "*",
                                style: textStyle20BoldRed,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            hint: 'Zip code',
                            controller: zipCodeController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 19),
                          Row(
                            children: [
                              Text(
                                "Phone Number",
                                style: textStyle20.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "*",
                                style: textStyle20BoldRed,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            hint: 'Country code',
                            controller: countryCodeController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            hint: 'Number',
                            controller: phoneNumberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (final value) {
                              setState(() {});
                            },
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: AppCustomColors.lightTextColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void selectImageSourceDialog() => showDialog(
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
                          Icon(Icons.photo_library_outlined,
                              color: Colors.black),
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
