import 'package:flutter/material.dart';

class RecipeTab extends StatefulWidget {
  final String name;
  final String imageLink;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final bool isInitiallyLiked;

  const RecipeTab({
    super.key,
    required this.name,
    required this.imageLink,
    required this.onTap,
    required this.onFavorite,
    required this.isInitiallyLiked,
  });

  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

class _RecipeTabState extends State<RecipeTab> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isInitiallyLiked;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    widget.onFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                widget.imageLink,
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
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.name,
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
                  onPressed: _toggleLike,
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : null,
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
