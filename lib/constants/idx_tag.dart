enum IdxTag { weddHole, studio, dress, makeup, coma, etc }

int? idxTagToValue(IdxTag? idxTag) {
  switch (idxTag) {
    case IdxTag.weddHole:
      return 1;
    case IdxTag.studio:
      return 2;
    case IdxTag.dress:
      return 3;
    case IdxTag.makeup:
      return 4;
    case IdxTag.coma:
      return 5;
    case IdxTag.etc:
      return 6;
    default:
      return null;
  }
}

String idxTagToString(IdxTag? idxTag) {
  switch (idxTag) {
    case IdxTag.weddHole:
      return "웨딩홀";
    case IdxTag.studio:
      return "스튜디오";
    case IdxTag.dress:
      return "드레스";
    case IdxTag.makeup:
      return "메이크업";
    case IdxTag.coma:
      return "혼수";
    case IdxTag.etc:
      return "기타";
    default:
      return "";
  }
}

IdxTag? valueToIdxTag(int? value) {
  switch (value) {
    case 1:
      return IdxTag.weddHole;
    case 2:
      return IdxTag.studio;
    case 3:
      return IdxTag.dress;
    case 4:
      return IdxTag.makeup;
    case 5:
      return IdxTag.coma;
    case 6:
      return IdxTag.etc;
    default:
      return null;
  }
}
