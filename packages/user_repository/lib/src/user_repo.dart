import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

abstract class UserRepository { 

  Stream<User?> get user;

  Future<void> signIn(String email, String password);
 
  Future<void> logOut();

  Future<MyUser> signUp (MyUser myUser, String password);

  Future<void> resetPassword(String email);

  // setUserData establecer datos de usuario
  Future<void> setUserData(MyUser user);
  // getMyUser obtenerMiUsuario
  Future<MyUser> getMyUser(String myUserId);

  Future<String> uploadPicture(String file, String userId);
}