import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class ReelsPagingManager {
  final _contentLoadThreshold = 5;
  final _contentSwipeDelay = const Duration(milliseconds: 300);
  final int _centerIdx = 10000;
  final Map<int, GetShortsResult?> _reelsItems = {};

  late int _currentPageIdx;
  late int _firstIdxPointer;
  late int _lastIdxPointer;

  get centerIdx => _centerIdx;
  get currentPageIdx => _currentPageIdx;

  final _reelsDisplayedSubject = PublishSubject<bool>();
  final _pageSwipableSubject = PublishSubject<bool>();
  final _playablePageIdxSubject = PublishSubject<int>();

  Stream<bool> get _reelsDisplayed => _reelsDisplayedSubject.stream;
  Stream<bool> get pageSwipeable => _pageSwipableSubject.stream;
  Stream<int> get playablePageIdx => _playablePageIdxSubject.stream;

  ReelsPagingManager() {
    _reelsDisplayed.listen((isDisplayed) =>
        isDisplayed ? _sinkPlayableIdx(_currentPageIdx) : _sinkPlayableIdx(-1));
  }

  Future<void> init() async {
    _reelsItems.clear();

    _currentPageIdx = _centerIdx;
    _firstIdxPointer = _centerIdx;
    _lastIdxPointer = _centerIdx;

    _lastIdxPointer = await _addNextContents(withCurrentLastIdx: true);
    _firstIdxPointer = await _addPrevContents();
  }

  void setPage(int pageIndex) {
    _sinkSwipeable(false);
    _setSelectedPageIdx(pageIndex);
  }

  Future<void> setPageSwipeable() async {
    await Future.delayed(_contentSwipeDelay, () => _sinkSwipeable(true));
  }

  Future<GetShortsResult?> getReels(int currentIdx) async {
    if (_isAroundLastIdx(currentIdx)) {
      _lastIdxPointer = await _addNextContents(withCurrentLastIdx: true);
    } else if (_isAroundFirstIdx(currentIdx)) {
      _firstIdxPointer = await _addPrevContents(withCurrentFirstIdx: true);
    }

    return _reelsItems[currentIdx];
  }

  void setReelsDisplayed(bool displayed) {
    _sinkReelsDisplayed(displayed);
  }

  void _sinkReelsDisplayed(bool displayed) {
    _reelsDisplayedSubject.sink.add(displayed);
  }

  void _sinkPlayableIdx(int pageIdx) {
    _playablePageIdxSubject.sink.add(pageIdx);
  }

  void _sinkSwipeable(bool isReady) {
    _pageSwipableSubject.sink.add(isReady);
  }

  void _setSelectedPageIdx(int pageIdx) {
    _setCurrentPageIdx(pageIdx);
    _sinkPlayableIdx(pageIdx);
  }

  void _setCurrentPageIdx(int pageIdx) {
    _currentPageIdx = pageIdx;
  }

  bool _isAroundLastIdx(int pageIdx) {
    return _lastIdxPointer == pageIdx + _contentLoadThreshold &&
        _isEmptyReelsItem(pageIdx + _contentLoadThreshold);
  }

  bool _isAroundFirstIdx(int pageIdx) {
    return _firstIdxPointer == pageIdx - _contentLoadThreshold &&
        _isEmptyReelsItem(pageIdx - _contentLoadThreshold);
  }

  bool _isEmptyReelsItem(int pageIdx) {
    return _reelsItems[pageIdx] == null;
  }

  void _setReels(int index, GetShortsResult? reelsItem) {
    _reelsItems[index] = reelsItem;
  }

  Future<int> _addPrevContents({bool withCurrentFirstIdx = false}) async {
    return _getReelsRandom().then((reels) {
      final reelsLength = reels?.length ?? 0;
      final startIdx =
          withCurrentFirstIdx ? _firstIdxPointer : _firstIdxPointer - 1;
      final newFirstIdx = startIdx - reelsLength;

      final videoPrevIdxs = [];

      for (int prevIdx = startIdx; prevIdx >= newFirstIdx; prevIdx--) {
        videoPrevIdxs.add(prevIdx);
      }

      for (int idx = 0; idx < reelsLength; idx++) {
        _setReels(videoPrevIdxs[idx], reels?[idx]);
      }

      return newFirstIdx;
    });
  }

  Future<int> _addNextContents({bool withCurrentLastIdx = false}) async {
    return _getReelsRandom().then((reels) {
      final reelsLength = reels?.length ?? 0;
      final startIdx =
          withCurrentLastIdx ? _lastIdxPointer : _lastIdxPointer + 1;
      final newLastIdx = startIdx + reelsLength;

      final videoNextIdxs = [];

      for (int nextIdx = startIdx; nextIdx <= newLastIdx; nextIdx++) {
        videoNextIdxs.add(nextIdx);
      }

      for (int idx = 0; idx < reelsLength; idx++) {
        _setReels(videoNextIdxs[idx], reels?[idx]);
      }

      return newLastIdx;
    });
  }

  Future<List<GetShortsResult>?> _getReelsRandom() async {
    try {
      if (getIt<MemberInfo>().isGuest()) {
        final response = await getIt<ApiShorts>().getGuestList();
        return response.result;
      } else {
        final response = await getIt<ApiShorts>().getList();
        return response.result;
      }
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }
}
