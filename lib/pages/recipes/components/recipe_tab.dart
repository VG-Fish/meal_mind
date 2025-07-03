import 'package:flutter/material.dart';

class RecipeTab extends StatelessWidget {
  final String name;
  final String imageLink;
  final VoidCallback onTap;

  const RecipeTab({
    super.key,
    required this.name,
    required this.imageLink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.bottomLeft,
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.network(
                imageLink,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                color: Colors.black.withValues(alpha: 0.5),
                padding: EdgeInsets.all(8),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
