enum Sort {
  MOST_RELATED,
  LATEST,
  LOWEST_TO_HIGHEST,
  HIGHEST_TO_LOWEST,
}

extension InfoSort on Sort {
  String getNameSort() {
    switch (this) {
      case Sort.MOST_RELATED:
        return "Liên quan nhất";
      case Sort.LATEST:
        return "Mới nhất";
      case Sort.LOWEST_TO_HIGHEST:
        return "Giá thấp đến cao";
      case Sort.HIGHEST_TO_LOWEST:
        return "Giá cao xuống thấp";
      default:
        return "";
    }
  }
}
