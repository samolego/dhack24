class ProductItem {
  final int id_izdelka;
  final int id_police;
  final String ime_izdelka;
  final bool in_stock;

  const ProductItem({
    required this.id_izdelka,
    required this.id_police,
    required this.ime_izdelka,
    this.in_stock = true,
  });
}
