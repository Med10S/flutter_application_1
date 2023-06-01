class EmailVerificationException implements Exception {
  final String message;

  const EmailVerificationException([this.message = "An unknown error occurred"]);

  factory EmailVerificationException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const EmailVerificationException('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const EmailVerificationException('This account has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const EmailVerificationException('No account found with this email.');
      case 'wrong-password':
        return const EmailVerificationException('Incorrect password. Please try again.');
      case 'too-many-requests':
        return const EmailVerificationException('Too many login attempts. Please try again later.');
      case 'operation-not-allowed':
        return const EmailVerificationException('Email/password login is not allowed for this app.');
      case 'network-request-failed':
        return const EmailVerificationException('A network error occurred. Please check your internet connection and try again.');
      case 'invalid-credential':
        return const EmailVerificationException('The provided credentials are invalid or have expired.');
      case 'invalid-verification-code':
        return const EmailVerificationException('The verification code provided is invalid.');
      case 'invalid-verification-id':
        return const EmailVerificationException('The verification ID provided is invalid.');
      case 'email-already-in-use':
        return const EmailVerificationException('This email is already in use.');
      default:
        return const EmailVerificationException();
    }
  }
}
