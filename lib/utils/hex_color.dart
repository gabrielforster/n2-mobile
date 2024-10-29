import 'package:flutter/material.dart';

class HexColor {
  static Color fromHex(String hexColor) {
    // Remove o símbolo '#' se estiver presente
    hexColor = hexColor.replaceAll('#', '');
    
    // Verifica se a string tem 6 ou 8 caracteres
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Adiciona opacidade total se não estiver presente
    } else if (hexColor.length != 8) {
      throw FormatException("Cor Hexadecimal deve conter de 6 a 8 caracteres");
    }

    // Converte a string hexadecimal para um inteiro e cria um objeto Color
    return Color(int.parse(hexColor, radix: 16));
  }
}
