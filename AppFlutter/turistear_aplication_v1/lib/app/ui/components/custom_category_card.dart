import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
            16.r), // Uso de ScreenUtil para radio de borde responsivo
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.w), // Uso de ScreenUtil para padding responsivo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 50.sp,
              color:
                  iconColor), // Uso de ScreenUtil para tamaño de icono responsivo
          SizedBox(height: 2.h), // Uso de ScreenUtil para espaciado responsivo
          Text(
            title,
            style: TextStyle(
                fontSize: 10.sp,
                color:
                    textColor), // Uso de ScreenUtil para tamaño de texto responsivo
          ),
        ],
      ),
    );
  }
}
