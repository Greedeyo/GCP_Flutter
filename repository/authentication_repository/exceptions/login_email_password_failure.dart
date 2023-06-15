
class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure([this.message = "알 수 없는 에러입니다"]);

  factory LoginWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure("존재하지 않는 이메일 입니다");
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure("비밀번호를 확인해주세요");
      case 'invalid-email':
        return const LoginWithEmailAndPasswordFailure("이메일을 확인해주세요");
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}