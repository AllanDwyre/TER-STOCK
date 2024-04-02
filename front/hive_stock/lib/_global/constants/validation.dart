final RegExp emailValidatorRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
final RegExp nameValidatorRegExp = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
final RegExp phoneValidatorRegExp =
    RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
final RegExp birthdayValidatorRegExp = RegExp(
    r"/^(?:0[1-9]|[12]\d|3[01])([ \/.-])(?:0[1-9]|1[012])\1(?:19|20)\d\d$");

// const String kEmailNullError = "Please enter your email";
// const String kInvalidEmail = "Please enter a valid email";
// const String kPasswordNullError = "Please enter your password";
// const String kPasswordMatchError = "Passwords do not match";
// const String kPasswordShort = "Password is too short";
// const String kFirstNameNullError = "Please enter your first name";
// const String kLastNameNullError = "Please enter your last name";
// const String kPhoneNumberNullError = "Please enter your phone number";
