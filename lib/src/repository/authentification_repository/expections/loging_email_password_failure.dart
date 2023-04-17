class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = "An unknown error occurred"]);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure('This account has been disabled. Please contact support for help.');
      case 'user-not-found':
        return LogInWithEmailAndPasswordFailure('No account found with this email.');
      case 'wrong-password':
        return LogInWithEmailAndPasswordFailure('Incorrect password. Please try again.');
      case 'too-many-requests':
        return LogInWithEmailAndPasswordFailure('Too many login attempts. Please try again later.');
      case 'operation-not-allowed':
        return LogInWithEmailAndPasswordFailure('Email/password login is not allowed for this app.');
      case 'network-request-failed':
        return LogInWithEmailAndPasswordFailure('A network error occurred. Please check your internet connection and try again.');
      case 'invalid-credential':
        return LogInWithEmailAndPasswordFailure('The provided credentials are invalid or have expired.');
      case 'invalid-verification-code':
        return LogInWithEmailAndPasswordFailure('The verification code provided is invalid.');
      case 'invalid-verification-id':
        return LogInWithEmailAndPasswordFailure('The verification ID provided is invalid.');
      default:
        return LogInWithEmailAndPasswordFailure();
    }
  }
}
