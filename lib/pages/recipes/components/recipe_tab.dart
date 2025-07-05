import 'package:flutter/material.dart';

class RecipeTab extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isLiked;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const RecipeTab({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isLiked,
    required this.onTap,
    required this.onFavorite,
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
            Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Card(
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
