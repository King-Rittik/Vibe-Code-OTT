import 'package:flutter/material.dart';
import 'package:kr_ott/core/theme.dart';
import 'package:kr_ott/data/dummy_data.dart';
import 'package:kr_ott/data/models/content_model.dart';
import 'package:kr_ott/screens/detail_screen.dart';
import 'package:kr_ott/screens/video_player_screen.dart';
import 'package:kr_ott/widgets/hero_banner.dart';
import 'package:kr_ott/widgets/category_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openDetail(BuildContext context, ContentModel content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(content: content)),
    );
  }

  void _openPlayer(BuildContext context, ContentModel content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VideoPlayerScreen(content: content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero Banner
          SliverToBoxAdapter(
            child: HeroBanner(
              items: DummyData.featured,
              onPlay: (c) => _openPlayer(context, c),
              onMoreInfo: (c) => _openDetail(context, c),
            ),
          ),

          // Content rows
          SliverToBoxAdapter(
            child: Column(
              children: [
                CategoryRow(
                  title: '🔥 Trending Now',
                  contents: DummyData.trending,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '✨ New Releases',
                  contents: DummyData.newReleases,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '🎬 Top Movies',
                  contents: DummyData.movies,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '📺 Binge-Worthy Series',
                  contents: DummyData.series,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '🚀 Sci-Fi Universe',
                  contents: DummyData.sciFi,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '🎥 Documentaries',
                  contents: DummyData.documentaries,
                  onTap: (c) => _openDetail(context, c),
                ),
                CategoryRow(
                  title: '⚡ Action & Adventure',
                  contents: DummyData.action,
                  onTap: (c) => _openDetail(context, c),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Builder(
        builder: (ctx) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Logo
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'KR',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        TextSpan(
                          text: 'stream',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _NavChip(label: 'Movies'),
                  const SizedBox(width: 8),
                  _NavChip(label: 'Series'),
                  const SizedBox(width: 8),
                  _NavChip(label: 'Kids'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  final String label;
  const _NavChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
