enum SessionType {
  musicDemo,
  musicDirect,
}

SessionType getSessionTypeFromString(String? sub) {
  switch (sub) {
    case 'MUSIC_DIRECT':
      return SessionType.musicDirect;

    case 'MUSIC_DEMO':
      return SessionType.musicDemo;

    default:
      return SessionType.musicDirect;
  }
}

String sessionTypeToString(SessionType session) {
  switch (session) {
    case SessionType.musicDemo:
      return 'MUSIC_DEMO';

    case SessionType.musicDirect:
      return 'MUSIC_DIRECT';

    default:
      return 'MUSIC_DIRECT';
  }
}
