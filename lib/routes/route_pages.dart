import 'package:dingmo/routes/arguments/arg_certifications.dart';
import 'package:dingmo/routes/arguments/arg_comp_edit_picto.dart';
import 'package:dingmo/routes/arguments/arg_comp_edit_preview_moreinfo.dart';
import 'package:dingmo/routes/arguments/arg_comp_edit_profile_preview.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile_moreinfo.dart';
import 'package:dingmo/routes/arguments/arg_feed_update.dart';
import 'package:dingmo/routes/arguments/arg_my_bookmark_folder_details.dart';
import 'package:dingmo/routes/arguments/arg_plan_edit_profile_preview.dart';
import 'package:dingmo/routes/arguments/arg_plan_profile.dart';
import 'package:dingmo/routes/arguments/arg_recovery_pass.dart';
import 'package:dingmo/routes/arguments/arg_search_profiles.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/args_search_idx_tag_result.dart';
import 'package:dingmo/third_party/certification.dart';
import 'package:dingmo/ui/account/areements.dart';
import 'package:dingmo/ui/account/change_pass.dart';
import 'package:dingmo/ui/account/login_email.dart';
import 'package:dingmo/ui/account/login_main.dart';
import 'package:dingmo/ui/account/permission.dart';
import 'package:dingmo/ui/account/send_recovery_email.dart';
import 'package:dingmo/ui/account/recovery_pass.dart';
import 'package:dingmo/ui/account/signup/comp_search_address.dart';
import 'package:dingmo/ui/account/signup/signup_company.dart';
import 'package:dingmo/ui/account/signup/signup_planner.dart';
import 'package:dingmo/ui/account/signup/signup_final.dart';
import 'package:dingmo/ui/account/signup/signup_id_pw.dart';
import 'package:dingmo/ui/account/signup/signup_type_select1.dart';
import 'package:dingmo/ui/account/signup/signup_type_select2.dart';
import 'package:dingmo/ui/account/verification.dart';
import 'package:dingmo/ui/app.dart';
import 'package:dingmo/ui/commons/feeds.dart';
import 'package:dingmo/ui/commons/reels.dart';
import 'package:dingmo/ui/commons/single_reels.dart';
import 'package:dingmo/ui/commons/view_photo.dart';
import 'package:dingmo/ui/commons/view_feed_item.dart';
import 'package:dingmo/ui/main/home/event_banners.dart';
import 'package:dingmo/ui/main/home/search_idx_tag_result.dart';
import 'package:dingmo/ui/main/home/search_profiles.dart';
import 'package:dingmo/ui/main/home/search.dart';
import 'package:dingmo/ui/main/home/search_comps_to_review.dart';
import 'package:dingmo/ui/main/mypage/comp_my_coupons.dart';
import 'package:dingmo/ui/main/mypage/my_settings.dart';
import 'package:dingmo/ui/main/mypage/consult_rooms.dart';
import 'package:dingmo/ui/main/mypage/consulting.dart';
import 'package:dingmo/ui/main/mypage/my_bookmark_folder_details.dart';
import 'package:dingmo/ui/main/mypage/my_bookmarks.dart';
import 'package:dingmo/ui/main/mypage/my_noti_settings.dart';
import 'package:dingmo/ui/main/mypage/privacy_policy.dart';
import 'package:dingmo/ui/main/mypage/terms_and_policies.dart';
import 'package:dingmo/ui/main/mypage/terms_of_use.dart';
import 'package:dingmo/ui/main/mypage/use_coupon.dart';
import 'package:dingmo/ui/main/mypage/user_consult_rooms.dart';
import 'package:dingmo/ui/main/mypage/user_consulting.dart';
import 'package:dingmo/ui/main/mypage/user_my_coupons.dart';
import 'package:dingmo/ui/main/mypage/user_my_info.dart';
import 'package:dingmo/ui/main/mypage/user_my_interests.dart';
import 'package:dingmo/ui/main/mypage/user_my_noti_settings.dart';
import 'package:dingmo/ui/main/mypage/user_my_points.dart';
import 'package:dingmo/ui/main/mypage/user_my_reviews.dart';
import 'package:dingmo/ui/main/mypage/user_my_settings.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_edit_picto.dart';
import 'package:dingmo/ui/profile/compOrPlan/review_update_page.dart';
import 'package:dingmo/ui/profile/compOrPlan/review_write_page.dart';
import 'package:dingmo/ui/profile/user/user_profile.dart';
import 'package:dingmo/ui/upload/feeds/feed_update.dart';
import 'package:dingmo/ui/upload/feeds/search_mention.dart';
import 'package:dingmo/ui/upload/reels/reels_upload.dart';
import 'package:dingmo/routes/arguments/arg_feed_upload.dart';
import 'package:dingmo/routes/arguments/arg_feeds.dart';
import 'package:dingmo/routes/arguments/arg_reels_bgm_selection.dart';
import 'package:dingmo/routes/arguments/arg_reels_preview.dart';
import 'package:dingmo/routes/arguments/arg_reels_upload.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/arguments/args_reels_filming.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_alarm_likes.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_alarms.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_edit_preview_moreinfo.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_edit_profile.dart';
import 'package:dingmo/ui/profile/compOrPlan/comp_edit_profile_preview.dart';
import 'package:dingmo/ui/profile/compOrPlan/plan_edit_profile.dart';
import 'package:dingmo/ui/profile/compOrPlan/plan_edit_profile_preview.dart';
import 'package:dingmo/ui/profile/compOrPlan/plan_profile.dart';

import 'arguments/args_search_result.dart';
import '../../ui/main/home/search_result.dart';
import '../../ui/main/mypage/comp_my_info.dart';
import '../ui/account/signup/signup_comp_type_select.dart';
import '../ui/account/signup/signup_user.dart';
import '../ui/main/mypage/plan_my_info.dart';
import '../ui/main/mypage/inquiry.dart';
import '../ui/main/mypage/notice.dart';
import '../ui/profile/compOrPlan/comp_profile.dart';
import '../ui/profile/compOrPlan/comp_profile_moreinfo.dart';
import '../ui/profile/compOrPlan/view_review_item.dart';
import '../ui/upload/feeds/feed_upload.dart';
import '../ui/upload/reels/reels_bgm_selection.dart';
import '../ui/upload/reels/reels_filming.dart';
import '../ui/upload/reels/reels_preview.dart';
import '../ui/upload/reels/reels_update.dart';
import 'arguments/arg_reels_update.dart';
import 'arguments/arg_view_photo.dart';
import 'arguments/arg_view_review_item.dart';

class RoutePages {
  static DingmoApp startPage(Object? arguments) {
    return const DingmoApp();
  }

  static PermissionPage permissionPage(Object? arguments) {
    return const PermissionPage();
  }

  static LoginMainPage loginMainPage(Object? arguments) {
    return const LoginMainPage();
  }

  static LoginEmailPage loginEmailPage(Object? arguments) {
    return const LoginEmailPage();
  }

  static SendRecoveryMailPage sendRecoveryMailPage(Object? arguments) {
    return const SendRecoveryMailPage();
  }

  static RecoveryPassPage recoveryPassPage(Object? arguments) {
    final RecoveryPassArgs args = arguments as RecoveryPassArgs;
    return RecoveryPassPage(email: args.email);
  }

  static ChangePassPage changePassPage(Object? arguments) {
    return const ChangePassPage();
  }

  static AgreementsPage agreementsPage(Object? arguments) {
    return const AgreementsPage();
  }

  static IdPwForSignUpPage idPwForSignUpPage(Object? arguments) {
    return const IdPwForSignUpPage();
  }

  static SignUpTypeSelect1Page signUpTypeSelect1Page(Object? arguments) {
    return const SignUpTypeSelect1Page();
  }

  static SignUpTypeSelect2Page signUpTypeSelect2Page(Object? arguments) {
    return const SignUpTypeSelect2Page();
  }

  static SignUpCompTypeSelectPage signUpCompTypeSelectPage(Object? arguments) {
    return const SignUpCompTypeSelectPage();
  }

  static SignUpUserNicknamePage signUpUserNicknamePage(Object? arguments) {
    return const SignUpUserNicknamePage();
  }

  static SignUpUserDateWeddingPage signUpUserDateWeddingPage(
      Object? arguments) {
    return const SignUpUserDateWeddingPage();
  }

  static SignUpUserOkPage signUpUserOkPage(Object? arguments) {
    return const SignUpUserOkPage();
  }

  static CompNumCheckPage compNumCheckPage(Object? arguments) {
    return const CompNumCheckPage();
  }

  static CompInfoDetailsCheckPage compInfoDetailsCheckPage(Object? arguments) {
    return const CompInfoDetailsCheckPage();
  }

  static PlannerTakeninCheckPage plannerTakeninCheckPage(Object? arguments) {
    return const PlannerTakeninCheckPage();
  }

  static SelfAuthPage selfAuthPage(Object? arguments) {
    return const SelfAuthPage();
  }

  static VerificationPage verificationPage(Object? arguments) {
    return const VerificationPage();
  }

  static CertificationsPage certificationsPage(Object? arguments) {
    final args = arguments as CertificationsArgs;

    return CertificationsPage(onComplete: args.onComplete);
  }

  static SignUpOkPage signUpOkPage(Object? arguments) {
    return const SignUpOkPage();
  }

  static CompSearchAddressPage compSearchAddressPage(Object? arguments) {
    return const CompSearchAddressPage();
  }

  static ViewPhotoPage viewPhotoPage(Object? arguments) {
    ViewPhotoArgs args = arguments as ViewPhotoArgs;
    return ViewPhotoPage(
      initViewIdx: args.initViewIdx,
      imageProviders: args.imageProviders,
      checkComplete: args.checkComplete,
    );
  }

  static ReelsFilmingPage reelsFilmingPage(Object? arguments) {
    final ReelsFilmingArgs args = arguments as ReelsFilmingArgs;
    return ReelsFilmingPage(
      pushReplacementHome: args.pushReplacementHome,
      frontCamera: args.frontCamera,
      backCamera: args.backCamera,
    );
  }

  static ReelsPreviewPage reelsPreviewPage(Object? arguments) {
    ReelsPreviewArgs args = arguments as ReelsPreviewArgs;
    return ReelsPreviewPage(
      videoFile: args.videoFile,
      isFilmed: args.isFilmed,
    );
  }

  static ReelsBgmSelectionPage reelsBgmSelectionPage(Object? arguments) {
    ReelsBgmSelectionArgs args = arguments as ReelsBgmSelectionArgs;
    return ReelsBgmSelectionPage(
      selectedIndex: args.selectedIndex,
    );
  }

  static ReelsUploadPage reelsUploadPage(Object? arguments) {
    ReelsUploadArgs args = arguments as ReelsUploadArgs;

    return ReelsUploadPage(
      videoFile: args.videoFile,
      videoDuration: args.videoDuration,
    );
  }

  static ReelsUpdatePage reelsUpdatePage(Object? arguments) {
    ReelsUpdateArgs args = arguments as ReelsUpdateArgs;

    return ReelsUpdatePage(contentId: args.contentId);
  }

  static HomeTabEventBannerListPage homeTabEventBannerListPage(
      Object? arguments) {
    return const HomeTabEventBannerListPage();
  }

  static SearchPage searchPage(Object? arguments) {
    return const SearchPage();
  }

  static SearchProfilesPage searchProfilesPage(Object? arguments) {
    final SearchProfilesArgs args = arguments as SearchProfilesArgs;

    return SearchProfilesPage(
      memberType: args.memberType,
      idxTag: args.idxTag,
      keyword: args.keyword,
    );
  }

  static SearchResultPage searchResultPage(Object? arguments) {
    final SearchResultArgs args = arguments as SearchResultArgs;
    return SearchResultPage(filter: args);
  }

  static SearchIdxTagResultPage searchIdxTagResultPage(Object? arguments) {
    final SearchIdxTagResultArgs args = arguments as SearchIdxTagResultArgs;
    return SearchIdxTagResultPage(idxTag: args.idxTag);
  }

  static ReelsListPage reelsPage(Object? arguments) {
    return const ReelsListPage();
  }

  static SingleReelsPage singleReelsPage(Object? arguments) {
    final SingleReelsArgs args = arguments as SingleReelsArgs;

    return SingleReelsPage(contentId: args.contentId);
  }

  static FeedsPage feedsPage(Object? arguments) {
    final FeedsArgs args = arguments as FeedsArgs;
    return FeedsPage(getFeeds: args.getFeeds);
  }

  static ViewFeedItemPage viewFeedItemPage(Object? arguments) {
    final ViewFeedItemArgs args = arguments as ViewFeedItemArgs;

    return ViewFeedItemPage(
      contentId: args.contentId,
    );
  }

  static FeedUploadPage feedUploadPage(Object? arguments) {
    final FeedUploadArgs args = arguments as FeedUploadArgs;

    return FeedUploadPage(images: args.images);
  }

  static FeedUpdatePage feedUpdatePage(Object? arguments) {
    final FeedUpdateArgs args = arguments as FeedUpdateArgs;

    return FeedUpdatePage(contentId: args.contentId);
  }

  static CompProfilePage compProfilePage(Object? arguments) {
    CompProfileArgs args = arguments as CompProfileArgs;
    return CompProfilePage(profileId: args.profileId);
  }

  static CompProfileMoreInfoPage compProfileMoreInfoPage(Object? arguments) {
    CompProfileMoreInfoArgs args = arguments as CompProfileMoreInfoArgs;
    return CompProfileMoreInfoPage(profileInfo: args.profileInfo);
  }

  static ViewReviewItemPage viewReviewItemPage(Object? arguments) {
    final ViewReviewItemArgs args = arguments as ViewReviewItemArgs;

    return ViewReviewItemPage(
      item: args.item,
    );
  }

  static CompMyCouponsPage myCouponsPage(Object? arguments) {
    return const CompMyCouponsPage();
  }

  static CompMyInfoPage compMyInfoPage(Object? arguments) {
    return const CompMyInfoPage();
  }

  static PlanMyInfoPage planMyInfoPage(Object? arguments) {
    return const PlanMyInfoPage();
  }

  static MySettingsPage mySettingsPage(Object? arguments) {
    return const MySettingsPage();
  }

  static MyNotiSettingsPage myNotiSettingsPage(Object? arguments) {
    return const MyNotiSettingsPage();
  }

  static CompEditProfilePage compEditProfilePage(Object? arguments) {
    return const CompEditProfilePage();
  }

  static CompEditPictoPage compEditPictoPage(Object? arguments) {
    final CompEditPictoArgs args = arguments as CompEditPictoArgs;

    return CompEditPictoPage(
        initPictos: args.initPictos, onPictoSelected: args.onPictoSelected);
  }

  static CompEditProfilePreviewPage compEditProfilePreviewPage(
      Object? arguments) {
    final CompEditProfilePreviewArgs args =
        arguments as CompEditProfilePreviewArgs;

    return CompEditProfilePreviewPage(form: args.form);
  }

  static CompEditProfilePreviewMoreInfoPage compEditProfilePreviewMoreInfoPage(
      Object? arguments) {
    final CompEditProfilePreviewMoreInfoArgs args =
        arguments as CompEditProfilePreviewMoreInfoArgs;

    return CompEditProfilePreviewMoreInfoPage(form: args.form);
  }

  static CompAlarmsPage compAlarmsPage(Object? arguments) {
    return const CompAlarmsPage();
  }

  static CompAlarmLikesPage compAlarmLikesPage(Object? arguments) {
    return const CompAlarmLikesPage();
  }

  static NoticePage noticePage(Object? arguments) {
    return const NoticePage();
  }

  static InquiryPage inquiryPage(Object? argumetns) {
    return const InquiryPage();
  }

  static TermsAndPoliciesPage termsAndPoliciesPage(Object? arguments) {
    return const TermsAndPoliciesPage();
  }

  static TermsOfUsePage termsOfUsePage(Object? arguments) {
    return const TermsOfUsePage();
  }

  static PrivacyPolicyPage privacyPolicyPage(Object? arguments) {
    return const PrivacyPolicyPage();
  }

  static PlanProfilePage plannerProfilePage(Object? arguments) {
    PlanProfileArgs args = arguments as PlanProfileArgs;
    return PlanProfilePage(profileId: args.profileId);
  }

  static PlanEditProfilePage planEditProfilePage(Object? arguments) {
    return const PlanEditProfilePage();
  }

  static PlanEditProfilePreviewPage planEditProfilePreviewPage(
      Object? arguments) {
    PlanEditProfilePreviewArgs args = arguments as PlanEditProfilePreviewArgs;

    return PlanEditProfilePreviewPage(form: args.form);
  }

  static ConsultRoomsPage consultRoomsPage(Object? arguments) {
    return const ConsultRoomsPage();
  }

  static ConsultingPage consultingPage(Object? arguments) {
    return const ConsultingPage();
  }

  static MyBookmarksPage myBookmarksPage(Object? arguments) {
    return const MyBookmarksPage();
  }

  static MybookmarkFolderDetailsPage mybookmarkFolderDetailsPage(
      Object? arguments) {
    MybookmarkFolderDetailsArgs args = arguments as MybookmarkFolderDetailsArgs;

    return MybookmarkFolderDetailsPage(
      item: args.item,
      onFolderEdited: args.onFolderEdited,
      onFolderDeleted: args.onFolderDeleted,
    );
  }

  static SearchMentionPage searchMentionPage(Object? arguments) {
    return const SearchMentionPage();
  }

  static ReviewWritePage reviewWritePage(Object? arguments) {
    return const ReviewWritePage();
  }

  static ReviewUpdatePage reviewUpdatePage(Object? arguments) {
    return const ReviewUpdatePage();
  }

  static UserProfilePage userProfilePage(Object? arguments) {
    return const UserProfilePage();
  }

  static UserMyInfoPage userMyInfoPage(Object? arguments) {
    return const UserMyInfoPage();
  }

  static UserMyPointsPage userMyPointsPage(Object? arguments) {
    return const UserMyPointsPage();
  }

  static UserMyInterestsPage userMyInterestsPage(Object? arguments) {
    return const UserMyInterestsPage();
  }

  static UserMyCouponsPage userMyCouponsPage(Object? arguments) {
    return const UserMyCouponsPage();
  }

  static UseCouponPage useCouponPage(Object? arguments) {
    return const UseCouponPage();
  }

  static UserMySettingsPage userMySettingsPage(Object? arguments) {
    return const UserMySettingsPage();
  }

  static UserMyNotiSettingsPage userMyNotiSettingsPage(Object? arguments) {
    return const UserMyNotiSettingsPage();
  }

  static UserConsultRoomsPage userConsultRoomsPage(Object? arguments) {
    return const UserConsultRoomsPage();
  }

  static UserConsultingPage userConsultingPage(Object? arguments) {
    return const UserConsultingPage();
  }

  static UserMyReviewsPage userMyReviewsPage(Object? arguments) {
    return const UserMyReviewsPage();
  }

  static SearchCompsForReviewPage searchCompsForReviewPage(Object? arguments) {
    return const SearchCompsForReviewPage();
  }
}
