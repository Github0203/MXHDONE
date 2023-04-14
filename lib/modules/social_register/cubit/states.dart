

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{
  late final String uId;
  SocialRegisterSuccessState(this.uId);
}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}




class SocialCreateUserSuccessState extends SocialRegisterStates{
  late final String uId;
  SocialCreateUserSuccessState(this.uId);
}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}
class VerifyUserSuccessState extends SocialRegisterStates{
  late final String uId;
  VerifyUserSuccessState(this.uId);
}
class VerifyUserErrorState extends SocialRegisterStates{
  final String error;
  VerifyUserErrorState(this.error);
}




class SocialAddPasswordStatue extends SocialRegisterStates{}

class CheckVerifySuccessState extends SocialRegisterStates{}
class CheckVerifyErrorState extends SocialRegisterStates{}