class Endpoints {
  Endpoints._();

  static const String apiUrl = "https://dev.dingmo.co.kr/api";
  static const String imgUrl = "https://img.dingmo.co.kr";
  static const String vodUrl = "https://vod.dingmo.co.kr";

  static const String existsNickname = "/exists/nickname";
  static const String existsEmail = "/exists/email";

  static const String signUpComp = "/sign/sign-up/comp";
  static const String signUpPlan = "/sign/sign-up/plan";
  static const String login = "/sign/login";
  static const String resign = "/sign/resign";

  static const String profileMypage = "/profile/mypage";
  static const String profileMyAreaExists = "/profile/my-area/exists";
  static const String profileComp = "/profile/comp";
  static const String profileCompGuest = "/profile/comp/guest";
  static const String profileCompPictos = "/profile/comp/pictos";
  static const String profileCompMyinfo = "/profile/comp/myinfo";
  static const String profileCompForm = "/profile/comp/form";
  static const String profilePlan = "/profile/plan";
  static const String profilePlanGuest = "/profile/plan/guest";
  static const String profilePlanMyinfo = "/profile/plan/myinfo";
  static const String profilePlanForm = "/profile/plan/form";

  static const String bookmarkFolder = "/bookmark/folder";
  static const String bookmarkFolderList = "/bookmark/folder/list";
  static const String bookmarkItem = "/bookmark/item";
  static const String bookmarkItemMultiple = "/bookmark/item/multiple";
  static const String bookmarkItemList = "/bookmark/item/list";

  static const String contentThumbnails = "/content/thumbnails";
  static const String contentBoard = "/content/board";
  static const String contentBoardList = "/content/board/list";
  static const String contentBoardGuest = "/content/board/guest";
  static const String contentBoardGuestList = "/content/board/guest/list";
  static const String contentBoardForm = "/content/board/form";
  static const String contentShorts = "/content/shorts";
  static const String contentShortsList = "/content/shorts/list";
  static const String contentShortsGuest = "/content/shorts/guest";
  static const String contentShortsGuestList = "/content/shorts/guest/list";
  static const String contentShortsForm = "/content/shorts/form";

  static const String couponComp = "/coupon/comp";
  static const String couponCompList = "/coupon/comp/list";
  static const String couponPlan = "/coupon/plan";
  static const String couponPlanList = "/coupon/plan/list";

  static const String search = "/search";
  static const String searchGuest = "/search/guest";
  static const String searchHome = "/search/home";
  static const String searchHomeGuest = "/search/home/guest";
  static const String searchProfile = "/search/profile";
  static const String searchProfileGuest = "/search/profile/guest";
  static const String searchProfileComp = "/search/profile/comp";
  static const String searchProfileCompGuest = "/search/profile/comp/guest";
  static const String searchReviewable = "/search/reviewable";
  static const String searchContent = "/search/content";
  static const String searchContentGuest = "/search/content/guest";
  static const String searchContentIdxTag = "/search/content/idx-tag";
  static const String searchContentIdxTagGuest =
      "/search/content/idx-tag/guest";
  static const String searchContentPanel = "/search/content/panel";
  static const String searchHistory = "/search/history";

  static const String areaFirstList = "/area/first/list";
  static const String areaSecondList = "/area/second/list";

  static const String bannerList = "/banner/list";

  static const String bgmList = "/bgm/list";

  static const String block = "/block";

  static const String comment = "/comment";
  static const String commentList = "/comment/list";
  static const String commentListGuest = "/comment/list/guest";

  static const String reply = "/reply";
  static const String replyList = "/reply/list";
  static const String replyListGuest = "/reply/list/guest";

  static const String uploadPhotoPresign = "/upload/photo/presign";
  static const String uploadProfilePresign = "/upload/profile/presign";
  static const String uploadThumbPresign = "/upload/thumbnail/presign";
  static const String uploadVideoPresign = "/upload/video/presign";

  static const String follow = "/follow";

  static const String like = "/like";
  static const String likeList = "/like/list";

  static const String notificationList = "/notification/list";

  static const String pointList = "/point/list";

  static const String setting = "/setting";

  static const String faqList = "/faq/list";

  static const String noticeList = "/notice/list";

  static const String inquiry = "/inquiry";
  static const String inquiryList = "/inquiry/list";

  static const String thirdPartyCertCorp = "/third-party/cert/corp";
  static const String thirdPartyCertPerson = "/third-party/cert/person";
  static const String thirdPartySearchAddress = "/third-party/search/address";
}
