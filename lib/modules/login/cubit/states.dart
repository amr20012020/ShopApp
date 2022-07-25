/* abstract class LoginStates {}

class initialLoginState extends LoginStates {}

class LogInLoadingState extends LoginStates {}

class LogInSuccessState extends LoginStates {}

class LogInErrorState extends LoginStates {}  */



abstract class LogInStates{}
class logInInitialState extends LogInStates{}


class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{}
class LogInErrorState extends LogInStates{
  late String error;
  LogInErrorState(this.error);
}



