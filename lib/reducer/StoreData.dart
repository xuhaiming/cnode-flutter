enum Actions {
  SetTitle,
}

class StoreData {
  final String title;

  StoreData({
    this.title,
  });

  StoreData copyWith({
    String title,
  }) {
    return StoreData(
      title: title ?? this.title,
    );
  }
}

StoreData reducer(StoreData state, dynamic action) {
  if (action == Actions.SetTitle) {
    return state.copyWith(
      title: 'test',
    );
  }

  return state;
}
