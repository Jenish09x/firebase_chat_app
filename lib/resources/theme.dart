part of 'resources.dart';

ThemeData get lightTheme => _getThemData(_lightColorScheme);

ThemeData _getThemData(ColorScheme colorScheme) => ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  fontFamily: FontFamily.nunitoSans,
  brightness: colorScheme.brightness,
  primaryColor: colorScheme.primary,
  canvasColor: colorScheme.surface,
  scaffoldBackgroundColor: colorScheme.surface,
  visualDensity: VisualDensity.standard,
  extensions: {appColor},
  hoverColor: colorScheme.surface.withAlpha(100),
  elevatedButtonTheme: _elevatedButtonThemeData(colorScheme),
  outlinedButtonTheme: _outlinedButtonThemeData(colorScheme),
  filledButtonTheme: _filledButtonThemeData(colorScheme),
  textButtonTheme: _textButtonThemeData(colorScheme),
  textTheme: _textTheme(colorScheme),
  inputDecorationTheme: _inputDecorationTheme(colorScheme),
  dividerTheme: DividerThemeData(color: colorScheme.outline, space: 1, thickness: 1),
  snackBarTheme: _snackBarThemeData(colorScheme),
  dialogTheme: _dialogTheme(colorScheme),
  bottomSheetTheme: _bottomSheetThemeData(colorScheme),
  datePickerTheme: _datePickerThemeData(colorScheme),
  timePickerTheme: _timePickerThemeData(colorScheme),
  scrollbarTheme: _scrollbarThemeData(colorScheme),
  popupMenuTheme: _popupMenuThemeData(colorScheme),
  appBarTheme: _appBarTheme(colorScheme),
  bottomNavigationBarTheme: _bottomNavigationBarThemeData(colorScheme),
  tabBarTheme: TabBarThemeData(indicatorColor: colorScheme.primary),
);

ColorScheme get _lightColorScheme => ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0E4CB6),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF841722).withColorOpacity(.2),
  onPrimaryContainer: Color(0xFFF78720),
  secondary: Color(0xFF005BFF),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFE53935),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFE53935).withColorOpacity(.1),
  onErrorContainer: Color(0xFFE53935),
  surface: Color(0xFFFAFAFA),
  onSurface: Color(0xFF13123A),
  surfaceContainer: Color(0xFFFFFFFF),
  onSurfaceVariant: Color(0xFF50555C),
  surfaceTint: Color(0xFF13123A),
  outline: Color(0xFFE0E0E6),
  outlineVariant: Color(0xFF841722).withColorOpacity(.4),
  shadow: Color(0xFFEBEBEB),
  inverseSurface: Color(0xFfD3D3D3),
);

StatusColor get appColor => StatusColor(
  info: Color(0xFF841722),
  onInfo: Color(0xFFFFFFFF),

  warning: Color(0xFFFFC107),
  onWarning: Color(0xFF191D21),

  failure: Color(0xFFE53935),
  onFailure: Color(0xFFFFFFFF),

  success: Color(0xFF4CAF50),
  onSuccess: Color(0xFFFFFFFF),
);

TextTheme _textTheme(ColorScheme colorScheme) {
  return TextTheme(
    displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: FontFamily.nunitoSans),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: FontFamily.nunitoSans),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: FontFamily.nunitoSans),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.nunitoSans),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: FontFamily.nunitoSans),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.nunitoSans),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: FontFamily.nunitoSans),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: FontFamily.nunitoSans),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: FontFamily.nunitoSans),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurfaceVariant,
      fontFamily: FontFamily.nunitoSans,
    ),
  );
}

SnackBarThemeData _snackBarThemeData(ColorScheme colorScheme) {
  return SnackBarThemeData(
    backgroundColor: colorScheme.primary,
    insetPadding: const EdgeInsets.fromLTRB(Spacing.normal, Spacing.normal, Spacing.normal, Spacing.small),
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    actionTextColor: colorScheme.onPrimary,
    disabledActionTextColor: colorScheme.onSurfaceVariant,
  );
}

DialogThemeData _dialogTheme(ColorScheme colorScheme) {
  return DialogThemeData(
    backgroundColor: colorScheme.surfaceDim,
    shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large),
    elevation: 0,
    barrierColor: Colors.black.withColorOpacity(0.7),
    insetPadding: EdgeInsets.all(Spacing.normal),
  );
}

BottomSheetThemeData _bottomSheetThemeData(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    backgroundColor: colorScheme.surfaceContainer,
    modalBackgroundColor: colorScheme.surfaceContainer,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: RadiusValues.xLarge)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
}

DatePickerThemeData _datePickerThemeData(ColorScheme colorScheme) {
  return DatePickerThemeData(
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large),
    headerBackgroundColor: colorScheme.primary,
    headerForegroundColor: colorScheme.onPrimary,
    backgroundColor: colorScheme.surfaceContainer,
  );
}

TimePickerThemeData _timePickerThemeData(ColorScheme colorScheme) {
  return TimePickerThemeData(
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large),
    backgroundColor: colorScheme.surfaceContainer,
    padding: const EdgeInsets.all(16),
    dialBackgroundColor: colorScheme.surfaceBright,
  );
}

ScrollbarThemeData _scrollbarThemeData(ColorScheme colorScheme) {
  return ScrollbarThemeData(
    thickness: const WidgetStatePropertyAll(Spacing.xSmall),
    thumbColor: WidgetStatePropertyAll(colorScheme.onSurfaceVariant),
    mainAxisMargin: Spacing.small,
    radius: RadiusValues.xSmall,
    crossAxisMargin: 2,
    interactive: true,
  );
}

PopupMenuThemeData _popupMenuThemeData(ColorScheme colorScheme) {
  return PopupMenuThemeData(
    color: colorScheme.surfaceContainer,
    elevation: 10,
    surfaceTintColor: colorScheme.surfaceContainer,
    shadowColor: colorScheme.shadow,
    shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
    position: PopupMenuPosition.under,
  );
}

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    scrolledUnderElevation: 0,
    centerTitle: false,
    surfaceTintColor: Colors.transparent,
    elevation: 3,
    shadowColor: AppColors.purpleShadow,
    iconTheme: IconThemeData(color: colorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
    titleTextStyle: _textTheme(
      colorScheme,
    ).labelLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface),
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData(ColorScheme colorScheme) {
  return BottomNavigationBarThemeData(
    backgroundColor: colorScheme.surface,
    selectedItemColor: colorScheme.primary,
    unselectedItemColor: colorScheme.onSurfaceVariant,
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData(ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor: colorScheme.primary.withColorOpacity(0.5),
      disabledForegroundColor: colorScheme.onPrimary,
      textStyle: _textTheme(colorScheme).labelLarge?.copyWith(color: colorScheme.onPrimary),
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
      minimumSize: Size(96, 48),
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonThemeData(ColorScheme colorScheme) {
  return OutlinedButtonThemeData(
    style:
        ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.onSurface),
          shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
          textStyle: _textTheme(colorScheme).labelLarge?.copyWith(color: colorScheme.onSurface),
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
          minimumSize: Size(96, 48),
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
        ).copyWith(
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: colorScheme.onSurfaceVariant.withColorOpacity(0.25));
            }
            return BorderSide(color: colorScheme.onSurface);
          }),
        ),
  );
}

FilledButtonThemeData _filledButtonThemeData(ColorScheme colorScheme) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor: colorScheme.primary.withColorOpacity(0.5),
      disabledForegroundColor: colorScheme.onPrimary,
      textStyle: _textTheme(
        colorScheme,
      ).labelMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
      minimumSize: Size(96, 56),
    ),
  );
}

TextButtonThemeData _textButtonThemeData(ColorScheme colorScheme) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      textStyle: _textTheme(colorScheme).labelMedium?.copyWith(color: colorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.xSmall),
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      minimumSize: Size(0, 38),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
  final border = OutlineInputBorder(
    borderRadius: ShapeBorderRadius.medium,
    borderSide: BorderSide(color: colorScheme.outline, width: 1),
  );

  final iconColor = WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.error)) return colorScheme.error;
    if (states.contains(WidgetState.focused)) return colorScheme.primary;
    return colorScheme.onSurfaceVariant;
  });

  return InputDecorationTheme(
    errorMaxLines: 4,
    hintStyle: _textTheme(
      colorScheme,
    ).labelMedium?.copyWith(fontWeight: FontWeight.w400, color: colorScheme.onSurfaceVariant),
    errorStyle: const TextStyle(fontFamily: FontFamily.nunitoSans, fontWeight: FontWeight.w500),
    contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium),
    border: border,
    disabledBorder: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.primary.withColorOpacity(.5))),
    focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.error)),
    errorBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.error)),
    suffixIconColor: iconColor,
    prefixIconColor: iconColor,
    fillColor: colorScheme.surfaceDim,
    filled: true,
    isDense: true,
    suffixIconConstraints: BoxConstraints(maxWidth: 60),
  );
}
