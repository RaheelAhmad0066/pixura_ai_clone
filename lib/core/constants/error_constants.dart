class ErrorConstants {
  // Authentication & Login Errors
  static const String googleSignInAborted = "Google sign-in aborted.";
  static const String googleAuthFailed = "Google authentication failed.";
  static const String googleSignInError = "Google sign-in error: ";
  static const String googleSignInFailed = "Google sign-in failed.";
  static const String appleSignInFailed = "Apple sign-in failed.";
  static const String appleSignInError = "Apple sign-in error: ";
  static const String socialSignInFailed = "Failed to sign in with ";
  static const String appleSignInMissingToken =
      "Apple sign-in failed: Missing identity token.";
  static const String missingAccessToken =
      " sign-in failed due to missing token.";
  static const String generalSignInError =
      "Sign-in failed. Please check your credentials.";
  static const String noPreviousSession =
      "You don't have a previous session. Please sign in with OTP or password first.";
  static const String failedFetchUserProfile = "Failed to fetch user profile";
  static const String failedCompleteLogin = "Failed to complete login";
  static const String accessDenied =
      "Access denied. You don't have access to this application.";
  static const String invalidUserData = "Invalid user data received";
  static const String failedProcessUserData = "Failed to process user data";

  // General Errors
  static const String generalError = "Something went wrong. Please try again.";
  static const String unknownError = "Unknown error.";
  static const String unexpectedError = "An unexpected error occurred";

  // OTP & Verification Errors
  static const String otpSentSuccessfully = "OTP sent successfully";
  static const String pleaseEnterCompleteOtp = "Please enter complete OTP";
  static const String invalidOtp = "Invalid OTP. Please try again.";

  // Profile & Settings Errors
  static const String pleaseSelectSpecialization =
      "Please select at least one specialization";
  static const String cameraPermissionDenied =
      "Camera permission denied. Please enable it in Settings.";
  static const String photoLibraryPermissionDenied =
      "Photo library permission denied. Please enable it in Settings.";
  static const String profileUpdatedSuccessfully =
      "Profile updated successfully";
  static const String profileUpdatedButFailedRefresh =
      "Profile updated but failed to refresh data";
  static const String failedUpdateProfile = "Failed to update profile";
  static const String userProfileUpdatedSuccessfully =
      "User profile updated successfully";

  // Medical History Errors
  static const String pleaseAnswerAllRequiredQuestions =
      "Please answer all required questions";
  static const String pleaseAcknowledgeConsent =
      "Please acknowledge the consent form before proceeding";
  static const String pleaseProvideSignature =
      "Please provide your signature before proceeding";
  static const String medicalHistorySavedSuccessfully =
      "Medical history saved successfully";
  static const String failedSaveMedicalHistory =
      "Failed to save medical history";
  static const String failedSaveMedicalHistoryWithError =
      "Failed to save medical history: ";
  static const String failedSaveSignature =
      "Failed to save signature. Please try again.";

  // SOAP Notes Errors
  static const String appointmentIdRequiredSoapNotes =
      "Appointment ID is required to submit SOAP notes";
  static const String pleaseFillinAtLeastOneSoapField =
      "Please fill in at least one SOAP field before submitting";
  static const String submissionFailed = "Submission failed: ";
  static const String errorLoadingSoapNoteDetails =
      "Error loading SOAP note details";
  static const String errorLoadingSoapNotes = "Error loading SOAP notes";
  static const String failedSharePdf = "Failed to share PDF: ";
  static const String failedPrint = "Failed to print: ";
  static const String soapFieldsPopulatedFromTranscription =
      "SOAP fields populated from transcription!";
  static const String transcriptionCompletedNoData =
      "Transcription completed, but no SOAP data was extracted from the audio.";
  static const String youreAllSet = "You're all set!";
  static const String successfullyFinishedAppointment =
      "You've successfully finished this appointment. You can always revisit it in your ";
  static const String completedAppointmentsTab = "Completed Appointments";
  static const String tabIfYouNeedRefresher = " tab if you need a refresher.";

  // Appointments & Waiting Room Errors
  static const String anotherAppointmentInProgress =
      "Another appointment is still in progress";
  static const String appointmentAcceptedSuccessfully =
      "Appointment accepted successfully";
  // static const String failedAcceptAppointment = "Failed to accept appointment";
  static const String noAppointments = "No Appointments";
  static const String scheduleIsClear =
      "Your schedule is clear. New appointments will appear here.";

  // Voice Recording & Transcription Errors
  static const String appointmentIdRequiredTranscription =
      "Appointment ID is required for transcription";
  static const String noRecordingAvailable =
      "No recording available for transcription";
  static const String processingYourVoice = "Processing your voice";
  static const String listeningAndFillingForm =
      "Listening and filling out your form";
  static const String recordingComplete = "Recording Complete";

  // Validation & Form Errors
  static const String itemAlreadyExists = "This item already exists";
  static const String failedLoadImage = "Failed to load image";
  static const String noRxOrderAvailable = "No RX order available";
  static const String failedOpenRxOrder = "Failed to open RX order";
  static const String failedVerifyOrder = "Failed to verify order";

  // File & Document Errors
  static const String fileUploadNotImplemented =
      "File upload functionality not yet implemented";
  static const String failedLoadData = "Failed to load data";
  static const String pleaseCheckConnection =
      "Please check your connection and try again.";
  static const String soapNoteNotFound = "SOAP Note Not Found";
  static const String requestedSoapNoteNotFound =
      "The requested SOAP note could not be found.";

  // Success Messages
  static const String loginSuccessful = "Login successful";
  static const String copiedToClipboard = "Copied to clipboard";
  static const String resetLinkSentSuccessfully =
      "Reset link sent successfully!";

  // UI Labels & Placeholders
  static const String loading = "Loading...";
  static const String phone = "Phone";
  static const String email = "Email";
  static const String cancel = "Cancel";
  static const String submit = "Submit";
  static const String save = "Save";
  static const String retry = "Retry";
  static const String ok = "OK";
  static const String close = "Close";
  static const String back = "Back";
  static const String next = "Next";
  static const String previous = "Previous";
  static const String home = "Home";
  static const String menu = "Menu";
  static const String search = "Search";
  static const String filter = "Filter";
  static const String sort = "Sort";
  static const String view = "View";
  static const String list = "List";
  static const String detail = "Detail";
  static const String info = "Info";
  static const String help = "Help";
  static const String support = "Support";
  static const String contact = "Contact";
  static const String call = "Call";
  static const String message = "Message";
  static const String notification = "Notification";
  static const String alert = "Alert";
  static const String warning = "Warning";
  static const String success = "Success";
  static const String error = "Error";
  static const String noItemsFound = "No items found";
  static const String startTypingToSearch = "Start typing to search...";
  static const String tryDifferentSearchTerm = "Try a different search term";
}
