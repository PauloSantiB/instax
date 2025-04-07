import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:instax/screens/home/post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const PostScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    state.user!.picture == ""

                        ///si no hay imagen
                        ? GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 500,
                                  maxWidth: 500,
                                  imageQuality: 40);

                              ///
                              ///
                              if (image != null) {
                                CroppedFile? croppedFile =
                                    await ImageCropper().cropImage(
                                  sourcePath: image.path,
                                  aspectRatio: const CropAspectRatio(
                                      ratioX: 1, ratioY: 1),
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square
                                  ],
                                  uiSettings: [
                                    AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor:
                                          Theme.of(context).colorScheme.primary,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false,
                                    ),
                                    IOSUiSettings(
                                      title: 'Cropper',
                                    ),
                                  ],
                                );
                                if (croppedFile != null) {
                                  setState(() {
                                    context.read<UpdateUserInfoBloc>().add(
                                        UploadPicture(
                                            croppedFile.path,
                                            context
                                                .read<MyUserBloc>()
                                                .state
                                                .user!
                                                .id));
                                  });
                                }
                              }
                            }, //si hay imagen
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle),
                              child: Icon(
                                CupertinoIcons.person,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      state.user!.picture!,

                                      ///Si el usuario ya tiene una foto (picture != ""), se muestra esa imagen en el AppBar.
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                    const SizedBox(width: 10),
                    Text("Welcome ${state.user!.name}"

                        ///Saluda al usuario por su nombre.
                        )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),

          ///boton para cerrar
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                },
                icon: Icon(
                  CupertinoIcons.square_arrow_right,
                  color: Theme.of(context).colorScheme.onBackground,
                ))
          ],
        ),
      ),
    );
  }
}
