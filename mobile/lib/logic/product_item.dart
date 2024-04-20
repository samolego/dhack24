class ProductItem {
  final int id_izdelka;
  final int id_police;
  final String ime_izdelka;
  final bool in_stock;

  const ProductItem({
    this.id_izdelka = 0,
    this.id_police = 0,
    required this.ime_izdelka,
    this.in_stock = true,
  });
}
