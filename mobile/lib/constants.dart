// The URL of Supabase project
import 'package:flutter/material.dart';

import 'logic/product_item.dart';

const DB_URL = 'https://clnlnfebnsppdpspvryr.supabase.co';
// Public key
const DB_KEY =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsbmxuZmVibnNwcGRwc3B2cnlyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM2MTc5NDQsImV4cCI6MjAyOTE5Mzk0NH0.ml9R-adBNPAeurdrQUJQHlGtNfQ89cSy6_RQwnEWHt8";

final Map<String, List<ProductItem>> shoppingLists = {
  'Tedenski': <ProductItem>[
    ProductItem(ime_izdelka: 'Mleko'),
    ProductItem(ime_izdelka: 'Kruh'),
    ProductItem(ime_izdelka: 'Jajca'),
    ProductItem(ime_izdelka: 'Maslo'),
    ProductItem(ime_izdelka: 'Sir'),
    ProductItem(ime_izdelka: 'Banane'),
  ],
  'Mercator': <ProductItem>[
    ProductItem(ime_izdelka: "Cvetača"),
    ProductItem(ime_izdelka: "Brokoli"),
    ProductItem(ime_izdelka: "Piščančje prsi"),
  ],
  'Test': <ProductItem>[
    ProductItem(ime_izdelka: "Žemljice"),
  ],
};

class AppColors {
  static Color primary = Colors.purple[100]!;
  static Color primaryDark = Colors.deepPurple;
}
