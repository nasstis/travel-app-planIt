import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/screens/user/blocs/bloc/user_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:user_repository/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final MyUser user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final color = MyThemeMode.isDark ? MyColors.light : MyColors.darkGrey;
  final fillColor = MyThemeMode.isDark ? MyColors.dark : MyColors.white;
  bool editRequired = false;
  File? newPhoto;

  @override
  void initState() {
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _passwordController.text = '********';
    super.initState();
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        newPhoto = File(returnedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: _pickImageFromGallery,
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: newPhoto != null
                              ? FileImage(newPhoto!)
                              : CachedNetworkImageProvider(
                                  widget.user.photo,
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.white.withOpacity(0.3),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.image,
                          color: MyColors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      maxLength: 40,
                      style: TextStyle(color: color),
                      cursorColor: color,
                      decoration: InputDecoration(
                        label: const Text('Name'),
                        labelStyle: TextStyle(color: color),
                        filled: true,
                        fillColor: fillColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: color),
                      cursorColor: color,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        labelStyle: TextStyle(color: color),
                        filled: true,
                        fillColor: fillColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                            .hasMatch(val)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: color),
                    cursorColor: color,
                    readOnly: true,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      labelStyle: TextStyle(color: color),
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(PageName.resetPasswordRoute);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Reset Password'),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                      color: MyColors.red,
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DeleteConfirmDialog(
                            title: "Confirm deletion",
                            content:
                                "Are you sure you want to delete your account?",
                            action: 'Delete',
                          );
                        },
                      ).then((deleteConfirmed) {
                        if (deleteConfirmed != null && deleteConfirmed) {
                          context.read<UserBloc>().add(DeleteAccount());
                          context.go(PageName.initRoute);
                        }
                      });
                    },
                    label: const Text(
                      'Delete account',
                      style: TextStyle(
                        color: MyColors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is EditProfileLoading) {
                    setState(() {
                      editRequired = true;
                    });
                  }
                  if (state is EditProfileSuccess) {
                    setState(() {
                      editRequired = false;
                    });
                    context.read<AuthBloc>().add(AuthUserChanged(state.user));
                    context.pop();
                  }
                  if (state is EditProfileFailure) {
                    setState(() {
                      editRequired = false;
                    });
                  }
                },
                child: ElevatedButton(
                  onPressed: editRequired
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            if (_nameController.text != widget.user.name ||
                                _emailController.text != widget.user.email) {
                              context.read<UserBloc>().add(
                                    EditProfile(_nameController.text,
                                        _emailController.text, newPhoto),
                                  );
                            } else if (newPhoto != null) {
                              context.read<UserBloc>().add(
                                    EditProfile(null, null, newPhoto),
                                  );
                            }
                          }
                        },
                  child: editRequired
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Save',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
