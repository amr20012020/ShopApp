import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit():super(logInInitialState());
  static LogInCubit get(context)=>BlocProvider.of(context);


  postLogIn({
    required String email,
    required String password,
  }){
    emit(LogInLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(LogInSuccessState());
    }).catchError((e){
      emit(LogInErrorState(e.toString()));
    });
  }
}
