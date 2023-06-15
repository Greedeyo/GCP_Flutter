
class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "알 수 없는 에러입니다"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('더 안전한 비밀번호를 설정해주세요');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('이메일 형식이 잘못되었습니다');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('이미 존재하는 이메일입니다');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('허락된 기능이 아닙니다');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('삭제된 계정입니다');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}