// The URL of Supabase project
import 'package:flutter/material.dart';

import 'logic/product_item.dart';

const DB_URL = 'https://clnlnfebnsppdpspvryr.supabase.co';
// Public key
const DB_KEY =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsbmxuZmVibnNwcGRwc3B2cnlyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM2MTc5NDQsImV4cCI6MjAyOTE5Mzk0NH0.ml9R-adBNPAeurdrQUJQHlGtNfQ89cSy6_RQwnEWHt8";

final Map<String, List<ProductItem>> shoppingLists = {
  'Tedenski': <ProductItem>[
    const ProductItem(ime_izdelka: 'Mleko'),
    const ProductItem(ime_izdelka: 'Kruh'),
    const ProductItem(ime_izdelka: 'Jajca'),
    const ProductItem(ime_izdelka: 'Maslo'),
    const ProductItem(ime_izdelka: 'Sir'),
    const ProductItem(ime_izdelka: 'Banane'),
  ],
  'Mercator': <ProductItem>[
    const ProductItem(ime_izdelka: "Cvetača"),
    const ProductItem(ime_izdelka: "Brokoli"),
    const ProductItem(ime_izdelka: "Piščančje prsi"),
  ],
  'Test': <ProductItem>[
    const ProductItem(ime_izdelka: "Žemljice"),
  ],
};

class AppColors {
  static Color primary = Colors.purple[100]!;
  static Color primaryDark = Colors.deepPurple;
}
