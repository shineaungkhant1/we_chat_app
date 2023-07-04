import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtoZRow extends StatelessWidget {
  const AtoZRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const StarIcon(),
           Padding(
             padding: const EdgeInsets.only(top: 8.0),
             child: Text(
              'A',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          ),
           ),
          ...List.generate(24, (index) {
            final letter = String.fromCharCode('B'.codeUnitAt(0) + index);
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                letter,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            );
          }),
           Padding(
             padding: const EdgeInsets.only(top: 8.0),
             child: Text(
              'Z',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          ),
           ),
        ],
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({super.key});


  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star,
      size: 22,
      color: Colors.green,
    );
  }
}

