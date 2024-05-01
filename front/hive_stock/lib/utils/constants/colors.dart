import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00677D),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFB4EBFF),
  onPrimaryContainer: Color(0xFF001F27),
  secondary: Color(0xFF4C626A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCEE6F0),
  onSecondaryContainer: Color(0xFF061E25),
  tertiary: Color(0xFF595C7E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDFE0FF),
  onTertiaryContainer: Color(0xFF161937),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFBFCFE),
  onBackground: Color(0xFF191C1D),
  surface: Color(0xFFFBFCFE),
  onSurface: Color(0xFF191C1D),
  surfaceVariant: Color(0xFFDBE4E8),
  onSurfaceVariant: Color(0xFF40484B),
  outline: Color(0xFF70787C),
  onInverseSurface: Color(0xFFEFF1F2),
  inverseSurface: Color(0xFF2E3132),
  inversePrimary: Color(0xFF5AD5F9),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00677D),
  outlineVariant: Color.fromARGB(255, 223, 232, 236),
  scrim: Color(0xFF000000),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF5AD5F9),
  onPrimary: Color(0xFF003642),
  primaryContainer: Color(0xFF004E5F),
  onPrimaryContainer: Color(0xFFB4EBFF),
  secondary: Color(0xFFB3CAD4),
  onSecondary: Color(0xFF1D333B),
  secondaryContainer: Color(0xFF344A52),
  onSecondaryContainer: Color(0xFFCEE6F0),
  tertiary: Color(0xFFC1C4EB),
  onTertiary: Color(0xFF2B2E4D),
  tertiaryContainer: Color(0xFF414465),
  onTertiaryContainer: Color(0xFFDFE0FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1D),
  onBackground: Color(0xFFE1E3E4),
  surface: Color(0xFF191C1D),
  onSurface: Color(0xFFE1E3E4),
  surfaceVariant: Color(0xFF40484B),
  onSurfaceVariant: Color(0xFFBFC8CC),
  outline: Color(0xFF899296),
  onInverseSurface: Color(0xFF191C1D),
  inverseSurface: Color(0xFFE1E3E4),
  inversePrimary: Color(0xFF00677D),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF5AD5F9),
  outlineVariant: Color(0xFF40484B),
  scrim: Color(0xFF000000),
);

const CustomColors lightCustomColors = CustomColors(
  sourceWarning: Color(0xFFFFBB33),
  warning: Color(0xFF7D5700),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDEAA),
  onWarningContainer: Color(0xFF271900),
  sourceSuccess: Color(0xFF12B76A),
  success: Color(0xFF006D3C),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF70FDA7),
  onSuccessContainer: Color(0xFF00210E),
);

const CustomColors darkCustomColors = CustomColors(
  sourceWarning: Color(0xFFFFBB33),
  warning: Color(0xFFFEBA32),
  onWarning: Color(0xFF422C00),
  warningContainer: Color(0xFF5F4100),
  onWarningContainer: Color(0xFFFFDEAA),
  sourceSuccess: Color(0xFF12B76A),
  success: Color(0xFF51DF8E),
  onSuccess: Color(0xFF00391D),
  successContainer: Color(0xFF00522C),
  onSuccessContainer: Color(0xFF70FDA7),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;

  @override
  CustomColors copyWith({
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
  }) {
    return CustomColors(
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
    );
  }
}