class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = "An unknown error occurred"]);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure('This account has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure('No account found with this email.');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure('Incorrect password. Please try again.');
      case 'too-many-requests':
        return const LogInWithEmailAndPasswordFailure('Too many login attempts. Please try again later.');
      case 'operation-not-allowed':
        return const LogInWithEmailAndPasswordFailure('Email/password login is not allowed for this app.');
      case 'network-request-failed':
        return const LogInWithEmailAndPasswordFailure('A network error occurred. Please check your internet connection and try again.');
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure('The provided credentials are invalid or have expired.');
      case 'invalid-verification-code':
        return const LogInWithEmailAndPasswordFailure('The verification code provided is invalid.');
      case 'invalid-verification-id':
        return const LogInWithEmailAndPasswordFailure('The verification ID provided is invalid.');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
