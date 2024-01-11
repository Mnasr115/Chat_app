import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isLoading = false;


  Future<void> signInUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      }
    }
    catch (error) {
      emit(LoginFailure(errorMessage: 'The error is ${error.toString()}'));
    }
  }

  Future<void> signUpUser({required String email, required String password}) async {
    emit(RegisterLoaded());
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(RegisterFailure(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(RegisterFailure(errorMessage: 'wrong password'));
      }
    }
    catch (error) {
      emit(RegisterFailure(errorMessage: 'The error is ${error.toString()}'));
    }
  }
}
