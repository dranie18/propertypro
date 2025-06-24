// Authentication-specific error and success messages
export const authMessages = {
  // Login errors
  login: {
    invalidCredentials: {
      title: 'Login Failed',
      message: 'Incorrect email or password. Please try again.'
    },
    emptyFields: {
      title: 'Fields Required',
      message: 'Please enter both email and password.'
    },
    userNotFound: {
      title: 'Account Not Found',
      message: 'No account found with this email. Please register first.'
    },
    accountLocked: {
      title: 'Account Locked',
      message: 'Your account has been temporarily locked due to multiple failed attempts.'
    },
    accountSuspended: {
      title: 'Account Suspended',
      message: 'Your account has been suspended. Please contact support.'
    },
    tooManyAttempts: {
      title: 'Too Many Attempts',
      message: 'Too many login attempts. Please try again later.'
    },
    serverError: {
      title: 'Connection Error',
      message: 'Unable to connect to the server. Please try again later.'
    },
    success: {
      title: 'Login Successful',
      message: 'Welcome back! You have successfully logged in.'
    }
  },
  
  // Registration errors
  register: {
    emailExists: {
      title: 'Email Already Registered',
      message: 'An account with this email already exists. Please use a different email.'
    },
    passwordTooShort: {
      title: 'Password Too Short',
      message: 'Password must be at least 8 characters long.'
    },
    passwordMismatch: {
      title: 'Passwords Don\'t Match',
      message: 'The passwords you entered don\'t match. Please try again.'
    },
    invalidEmail: {
      title: 'Invalid Email',
      message: 'Please enter a valid email address.'
    },
    missingFields: {
      title: 'Missing Information',
      message: 'Please fill in all required fields.'
    },
    success: {
      title: 'Registration Successful',
      message: 'Your account has been created successfully!'
    }
  },
  
  // Password reset
  passwordReset: {
    emailSent: {
      title: 'Reset Link Sent',
      message: 'A password reset link has been sent to your email.'
    },
    emailNotFound: {
      title: 'Email Not Found',
      message: 'No account found with this email address.'
    },
    resetSuccess: {
      title: 'Password Reset',
      message: 'Your password has been reset successfully. You can now log in.'
    },
    invalidToken: {
      title: 'Invalid Link',
      message: 'This password reset link is invalid or has expired.'
    }
  },
  
  // Session
  session: {
    expired: {
      title: 'Session Expired',
      message: 'Your session has expired. Please log in again.'
    },
    logoutSuccess: {
      title: 'Logged Out',
      message: 'You have been successfully logged out.'
    }
  }
};