part of 'share_view_cubit.dart';

@freezed
class ShareviewEvent with _$ShareviewEvent {
  const factory ShareviewEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
