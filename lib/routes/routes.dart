import 'package:dingmo/routes/route_pages.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String start = '/';
  static const String sample = '/sample';
  static const String permission = '/permission';
  static const String loginMain = '/loginMain';
  static const String loginEmail = '/loginEmail';
  static const String recoveryPass = '/recoveryPass';
  static const String changePass = '/changePass';
  static const String sendRecoveryMail = '/sendRecoveryMail';
  static const String agreements = '/agreements';
  static const String idPwForSignUp = '/idPwForSignUp';
  static const String signupTypeSelect1 = '/signupTypeSelect1';
  static const String signupTypeSelect2 = '/signupTypeSelect2';
  static const String signupCompTypeSelect = '/signupCompTypeSelect';
  static const String signupUserNickname = '/signupUserNickname';
  static const String signUpUserDateWedding = '/signUpUserDateWedding';
  static const String signUpUserOk = '/signUpUserOk';
  static const String compNumCheck = '/compNumCheck';
  static const String compInfoDetails = '/compInfoDetails';
  static const String plannerTakeninCheck = '/plannerTakeinCheck';
  static const String selfAuth = '/selfAuth';
  static const String verification = '/verification';
  static const String certifications = '/certification';
  static const String signUpOk = '/signUpOk';
  static const String compSearchAddress = '/compSearchAddress';
  static const String viewPhoto = '/viewPhoto';
  static const String reelsFilming = '/reelsFilming';
  static const String reelsPreview = '/reelsPreview';
  static const String reelsBgmSelection = '/reelsPreview/reelsBgmSelection';
  static const String reelsUpload = '/reelsUpload';
  static const String reelsUpdate = '/reelsUpdate';
  static const String homeTabEventBannerList = '/homeTabEventBannerList';
  static const String search = '/search';
  static const String searchProfiles = '/searchProfiles';
  static const String searchResult = '/searchResult';
  static const String searchIdxTagResult = '/searchIdxTagResult';
  static const String reels = '/reels';
  static const String singleReels = '/singleReels';
  static const String feeds = '/feeds';
  static const String viewFeedItem = '/viewFeedItem';
  static const String feedUpload = '/feedUpload';
  static const String feedUpdate = '/feedUpdate';
  static const String compProfile = '/compProfile';
  static const String compProfileMoreInfo = '/compProfileMoreInfo';
  static const String viewReviewItem = '/viewReviewItem';
  static const String myCoupons = '/myCoupons';
  static const String compMyInfo = '/compMyInfo';
  static const String planMyInfo = '/plannerMyInfo';
  static const String mySettings = '/compMySettings';
  static const String myNotiSettings = '/myNotiSettings';
  static const String compEditProfile = '/compEditProfile';
  static const String compEditPicto = '/compEditPicto';
  static const String compEditProfilePreview = '/compEditProfilePreview';
  static const String compEditPreviewMoreInfo = '/compPreviewMoreInfo';
  static const String compAlarms = '/compAlarms';
  static const String compAlarmLikes = '/compAlarmLikes';
  static const String notice = '/notice';
  static const String inquiry = '/inquiry';
  static const String termsAndPolicies = '/termsAndPolicies';
  static const String termsOfUse = '/termsOfUse';
  static const String privacyPolicy = '/privacyPolicy';
  static const String planProfile = '/planProfile';
  static const String planEditProfile = '/planEditProfile';
  static const String planEditProfilePreview = '/planEditProfilePreview';
  static const String consultRooms = '/consultRooms';
  static const String consulting = '/consulting';
  static const String myBookmarks = '/myBookmarks';
  static const String mybookmarkFolderDetails = '/mybookmarkFolderDetails';
  static const String searchMention = '/searchMention';
  static const String reviewWrite = '/reviewWrite';
  static const String reviewUpdate = '/reviewUpdate';
  static const String userProfile = '/userProfile';
  static const String userMyInfo = '/userMyInfo';
  static const String userMyPoints = '/userMyPoints';
  static const String userMyInterests = '/userMyInterests';
  static const String userMyCoupons = '/userMyCoupons';
  static const String useCoupon = '/useCoupon';
  static const String userMyNotiSettings = '/userMyNotiSettings';
  static const String userMySettings = '/userMySettings';
  static const String userConsultRooms = '/userConsultRooms';
  static const String userConsulting = '/userConsulting';
  static const String userMyReviews = '/userMyReviews';
  static const String searchCompsForReview = '/searchCompsForReview';

  static final _routes = <String, WidgetGenFunc>{
    start: RoutePages.startPage,
    permission: RoutePages.permissionPage,
    loginMain: RoutePages.loginMainPage,
    loginEmail: RoutePages.loginEmailPage,
    recoveryPass: RoutePages.recoveryPassPage,
    changePass: RoutePages.changePassPage,
    sendRecoveryMail: RoutePages.sendRecoveryMailPage,
    agreements: RoutePages.agreementsPage,
    idPwForSignUp: RoutePages.idPwForSignUpPage,
    signupTypeSelect1: RoutePages.signUpTypeSelect1Page,
    signupTypeSelect2: RoutePages.signUpTypeSelect2Page,
    signupCompTypeSelect: RoutePages.signUpCompTypeSelectPage,
    signupUserNickname: RoutePages.signUpUserNicknamePage,
    signUpUserDateWedding: RoutePages.signUpUserDateWeddingPage,
    signUpUserOk: RoutePages.signUpUserOkPage,
    compNumCheck: RoutePages.compNumCheckPage,
    compInfoDetails: RoutePages.compInfoDetailsCheckPage,
    plannerTakeninCheck: RoutePages.plannerTakeninCheckPage,
    selfAuth: RoutePages.selfAuthPage,
    verification: RoutePages.verificationPage,
    certifications: RoutePages.certificationsPage,
    signUpOk: RoutePages.signUpOkPage,
    compSearchAddress: RoutePages.compSearchAddressPage,
    viewPhoto: RoutePages.viewPhotoPage,
    reelsFilming: RoutePages.reelsFilmingPage,
    reelsPreview: RoutePages.reelsPreviewPage,
    reelsBgmSelection: RoutePages.reelsBgmSelectionPage,
    reelsUpload: RoutePages.reelsUploadPage,
    reelsUpdate: RoutePages.reelsUpdatePage,
    homeTabEventBannerList: RoutePages.homeTabEventBannerListPage,
    search: RoutePages.searchPage,
    searchProfiles: RoutePages.searchProfilesPage,
    searchResult: RoutePages.searchResultPage,
    searchIdxTagResult: RoutePages.searchIdxTagResultPage,
    reels: RoutePages.reelsPage,
    singleReels: RoutePages.singleReelsPage,
    feeds: RoutePages.feedsPage,
    viewFeedItem: RoutePages.viewFeedItemPage,
    feedUpload: RoutePages.feedUploadPage,
    feedUpdate: RoutePages.feedUpdatePage,
    compProfile: RoutePages.compProfilePage,
    compProfileMoreInfo: RoutePages.compProfileMoreInfoPage,
    viewReviewItem: RoutePages.viewReviewItemPage,
    myCoupons: RoutePages.myCouponsPage,
    compMyInfo: RoutePages.compMyInfoPage,
    planMyInfo: RoutePages.planMyInfoPage,
    mySettings: RoutePages.mySettingsPage,
    myNotiSettings: RoutePages.myNotiSettingsPage,
    compEditProfile: RoutePages.compEditProfilePage,
    compEditPicto: RoutePages.compEditPictoPage,
    compEditProfilePreview: RoutePages.compEditProfilePreviewPage,
    compEditPreviewMoreInfo: RoutePages.compEditProfilePreviewMoreInfoPage,
    compAlarms: RoutePages.compAlarmsPage,
    compAlarmLikes: RoutePages.compAlarmLikesPage,
    notice: RoutePages.noticePage,
    inquiry: RoutePages.inquiryPage,
    termsAndPolicies: RoutePages.termsAndPoliciesPage,
    termsOfUse: RoutePages.termsOfUsePage,
    privacyPolicy: RoutePages.privacyPolicyPage,
    planProfile: RoutePages.plannerProfilePage,
    planEditProfile: RoutePages.planEditProfilePage,
    planEditProfilePreview: RoutePages.planEditProfilePreviewPage,
    consultRooms: RoutePages.consultRoomsPage,
    consulting: RoutePages.consultingPage,
    myBookmarks: RoutePages.myBookmarksPage,
    mybookmarkFolderDetails: RoutePages.mybookmarkFolderDetailsPage,
    searchMention: RoutePages.searchMentionPage,
    reviewWrite: RoutePages.reviewWritePage,
    reviewUpdate: RoutePages.reviewUpdatePage,
    userProfile: RoutePages.userProfilePage,
    userMyInfo: RoutePages.userMyInfoPage,
    userMyPoints: RoutePages.userMyPointsPage,
    userMyInterests: RoutePages.userMyInterestsPage,
    userMyCoupons: RoutePages.userMyCouponsPage,
    useCoupon: RoutePages.useCouponPage,
    userMyNotiSettings: RoutePages.userMyNotiSettingsPage,
    userMySettings: RoutePages.userMySettingsPage,
    userConsulting: RoutePages.userConsultingPage,
    userConsultRooms: RoutePages.userConsultRoomsPage,
    userMyReviews: RoutePages.userMyReviewsPage,
    searchCompsForReview: RoutePages.searchCompsForReviewPage
  };

  static Widget getPage(RouteSettings settings) =>
      _routes[settings.name]!(settings.arguments);
}
