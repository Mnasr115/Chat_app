import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool isLoading = false;

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
