import 'package:flutter/material.dart';

class HexColor {
  static Color fromHex(String hexColor) {
    // Remove o símbolo '#' se estiver presente
    hexColor = hexColor.replaceAll('#', '');
    
    // Verifica se a string tem 6 ou 8 caracteres
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Adiciona opacidade total se não estiver presente
    } else if (hexColor.length != 8) {
      throw FormatException("Hex color must be 6 or 8 characters long.");
    }

    // Converte a string hexadecimal para um inteiro e cria um objeto Color
    return Color(int.parse(hexColor, radix: 16));
  }
}
