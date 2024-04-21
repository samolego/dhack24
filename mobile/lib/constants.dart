// The URL of Supabase project
import 'package:flutter/material.dart';

import 'logic/product_item.dart';

const DB_URL = 'https://clnlnfebnsppdpspvryr.supabase.co';
// Public key
const DB_KEY =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsbmxuZmVibnNwcGRwc3B2cnlyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM2MTc5NDQsImV4cCI6MjAyOTE5Mzk0NH0.ml9R-adBNPAeurdrQUJQHlGtNfQ89cSy6_RQwnEWHt8";

final Map<String, List<ProductItem>> shoppingLists = {
  'Tedenski': <ProductItem>[
    ProductItem(ime_izdelka: 'Mleko', id_police: 4),
    ProductItem(ime_izdelka: 'Kruh', id_police: 6),
    ProductItem(ime_izdelka: 'Jajca', id_police: 4),
    ProductItem(ime_izdelka: 'Maslo', id_police: 4),
    ProductItem(ime_izdelka: 'Sir', id_police: 4),
    ProductItem(ime_izdelka: 'Banane', id_police: 1),
  ],
  'Mercator': <ProductItem>[
    ProductItem(ime_izdelka: "Cvetača", id_police: 2),
    ProductItem(ime_izdelka: "Brokoli", id_police: 2),
    ProductItem(ime_izdelka: "Piščančje prsi", id_police: 5),
  ],
  'Test': <ProductItem>[
    ProductItem(ime_izdelka: "Žemljice", id_police: 6),
  ],
};

class AppColors {
  static Color primary = Colors.purple[100]!;
  static Color primaryDark = Colors.deepPurple;
}
