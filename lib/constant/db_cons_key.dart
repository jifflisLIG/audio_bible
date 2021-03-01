class DBKey {
  String tag = 'db_key';

  ///table reading progress
  ///
  ///
  static String TBL_READING_PROGRESS = 'reading_progress';
  static String FRD_BOOK_ID = 'book_id';
  static String FRD_CHAPTER_ID = 'chapter_id';
  static String FRD_CHAPTER = 'chapter';

  ///table language
  ///
  ///
  static String TBL_LANGUAGE = 'language';
  static String FL_ID = 'id';
  static String FL_NAME = 'name';
  static String FL_LANGUAGE='langauge';
  static String FL_COUNTRY = 'country';
  static String FL_AUDIO_ID = 'audio_id';
  static String FL_ISDEFAULT ='is_default';
  static String FL_ABBREVIATION = 'abbreviation';

  ///table book
  ///
  ///
  static String TBL_BOOK='books';
  static String FB_ID = 'id';
  static String FB_BIBLE_ID = 'bible_id';
  static String FB_ABBREVIATION = 'abbreviation';
  static String FB_NAME = 'name';
  static String FB_NAME_LONG = 'name_long';
  static String FB_TOTAL_CHAPTER = 'total_chapter';
  static String FB_IS_SELECTED = 'is_selected';
}
