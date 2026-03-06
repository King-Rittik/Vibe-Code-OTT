import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kr_ott/core/theme.dart';
import 'package:kr_ott/data/models/content_model.dart';

class CategoryRow extends StatelessWidget {
  final String title;
  final List<ContentModel> contents;
  final Function(ContentModel) onTap;
  final double cardWidth;
  final double cardHeight;

  const CategoryRow({
    super.key,
    required this.title,
    required this.contents,
    required this.onTap,
    this.cardWidth = 120,
    this.cardHeight = 175,
  });

  @override
  Widget build(BuildContext context) {
    if (contents.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 18,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        color: AppTheme.primary.withOpacity(0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: AppTheme.primary.withOpacity(0.9), size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: cardHeight + 4,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16, right: 8),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final content = contents[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _SmallCard(
                  content: content,
                  width: cardWidth,
                  height: cardHeight,
                  onTap: () => onTap(content),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SmallCard extends StatefulWidget {
  final ContentModel content;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _SmallCard({
    required this.content,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<_SmallCard> createState() => __SmallCardState();
}

class __SmallCardState extends State<_SmallCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 160),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.06)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (ctx, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.content.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Shimmer.fromColors(
                    baseColor: AppTheme.surfaceVariant,
                    highlightColor: AppTheme.surface,
                    child: Container(color: AppTheme.surfaceVariant),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.surfaceVariant,
                          AppTheme.cardBg,
                        ],
                      ),
                    ),
                    child: const Icon(Icons.movie_outlined,
                        color: AppTheme.textMuted),
                  ),
                ),
              ),
              // gradient
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.75),
                      ],
                    ),
                  ),
                ),
              ),
              // Badges
              if (widget.content.isNew || widget.content.isTrending)
                Positioned(
                  top: 7,
                  left: 7,
                  child: widget.content.isNew
                      ? _Badge('NEW', AppTheme.primary)
                      : _Badge('HOT', const Color(0xFFFF6B35)),
                ),
              // Rating & play
              Positioned(
                bottom: 7,
                left: 8,
                right: 8,
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppTheme.gold, size: 11),
                    const SizedBox(width: 2),
                    Text(
                      widget.content.rating.toStringAsFixed(1),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 0.5),
                      ),
                      child: const Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
