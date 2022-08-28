class AuthStates{}
class InitialApp extends AuthStates{}
class ChangePasswordVisibilityState extends AuthStates{}

class ChangeBottomNAvBarState extends AuthStates{}
class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{
  final String uid;
  final String email;
  LoginSuccessState(this.uid,this.email);
}
class LoginErrorState extends AuthStates{
  final  onError;
  LoginErrorState(this.onError);
}

class RegisterLoadingState extends AuthStates{}
class DeleteAccountState extends AuthStates{}
class RegisterSuccessState extends AuthStates{
  final String uid;
  final String email;
  RegisterSuccessState(this.uid,this.email);
}
class RegisterErrorState extends AuthStates{
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends AuthStates{
  final String uid;
  CreateUserSuccessState(this.uid);
}
class CreateUserErrorState extends AuthStates{
  final  error;
  CreateUserErrorState(this.error);
}

class LoginWithGoogle extends AuthStates{
  final String uid;
  final String email;
  LoginWithGoogle(this.uid,this.email);
}

