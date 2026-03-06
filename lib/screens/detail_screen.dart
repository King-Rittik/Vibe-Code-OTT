import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kr_ott/core/theme.dart';
import 'package:kr_ott/data/models/content_model.dart';
import 'package:kr_ott/data/dummy_data.dart';
import 'package:kr_ott/screens/video_player_screen.dart';
import 'package:kr_ott/widgets/category_row.dart';

class DetailScreen extends StatefulWidget {
  final ContentModel content;

  const DetailScreen({super.key, required this.content});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isInMyList = false;
  bool _isLiked = false;

  void _openPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPlayerScreen(content: widget.content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.content;
    final related = DummyData.allContent
        .where((x) => x.id != c.id && x.genres.any((g) => c.genres.contains(g)))
        .take(6)
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with backdrop
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 16),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: c.backdropUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  // Play button overlay
                  Center(
                    child: GestureDetector(
                      onTap: _openPlayer,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54, width: 2),
                        ),
                        child: const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    c.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Metadata
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _MetaChip(label: '${c.year}'),
                      _MetaChip(label: c.duration),
                      _MetaChip(label: c.ageRating, isHighlighted: true),
                      _MetaChip(label: c.language),
                      if (c.contentType == 'series')
                        _MetaChip(
                            label:
                                '${c.seasons} Season${c.seasons > 1 ? 's' : ''}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Rating
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: c.rating / 2,
                        itemBuilder: (_, __) => const Icon(Icons.star_rounded,
                            color: AppTheme.gold),
                        itemCount: 5,
                        itemSize: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${c.rating}/10',
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Play Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openPlayer,
                      icon: const Icon(Icons.play_arrow_rounded,
                          color: Colors.black, size: 24),
                      label: const Text(
                        'Play Now',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Download Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download_rounded,
                          color: Colors.white, size: 22),
                      label: const Text(
                        'Download',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.surfaceVariant,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    c.description,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ActionButton(
                        icon: _isInMyList
                            ? Icons.check_circle_rounded
                            : Icons.add_circle_outline_rounded,
                        label: _isInMyList ? 'In My List' : 'My List',
                        color: _isInMyList ? AppTheme.green : Colors.white,
                        onTap: () => setState(() => _isInMyList = !_isInMyList),
                      ),
                      _ActionButton(
                        icon: _isLiked
                            ? Icons.thumb_up_rounded
                            : Icons.thumb_up_outlined,
                        label: 'Like',
                        color: _isLiked ? AppTheme.primary : Colors.white,
                        onTap: () => setState(() => _isLiked = !_isLiked),
                      ),
                      _ActionButton(
                        icon: Icons.share_rounded,
                        label: 'Share',
                        color: Colors.white,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Divider
                  const Divider(color: AppTheme.divider),
                  const SizedBox(height: 12),
                  // Genres
                  if (c.genres.isNotEmpty) ...[
                    const Text('Genres',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: c.genres
                          .map((g) => Chip(
                                label: Text(g,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                backgroundColor: AppTheme.surfaceVariant,
                                side: BorderSide.none,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  // Cast
                  if (c.cast.isNotEmpty) ...[
                    const Text('Cast',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(
                      c.cast.join(', '),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                  ],
                  // Director
                  if (c.director.isNotEmpty) ...[
                    const Text('Director',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(
                      c.director,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Related content
          if (related.isNotEmpty)
            SliverToBoxAdapter(
              child: CategoryRow(
                title: 'More Like This',
                contents: related,
                onTap: (content) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(content: content),
                    ),
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final bool isHighlighted;

  const _MetaChip({required this.label, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isHighlighted ? AppTheme.surfaceVariant : Colors.transparent,
        border: Border.all(
            color: isHighlighted
                ? AppTheme.primary.withOpacity(0.5)
                : AppTheme.divider),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isHighlighted ? AppTheme.primary : AppTheme.textSecondary,
          fontSize: 12,
          fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(label,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
