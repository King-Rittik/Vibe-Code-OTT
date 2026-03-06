import 'package:flutter/material.dart';
import 'package:kr_ott/core/theme.dart';
import 'package:kr_ott/data/dummy_data.dart';
import 'package:kr_ott/data/models/content_model.dart';
import 'package:kr_ott/screens/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  List<ContentModel> _results = [];
  bool _isSearching = false;
  String _activeFilter = 'All';
  final List<String> _filters = ['All', 'Movies', 'Series', 'Documentaries'];

  void _search(String q) {
    setState(() {
      _isSearching = q.isNotEmpty;
      if (q.isEmpty) {
        _results = [];
      } else {
        var res = DummyData.search(q);
        if (_activeFilter == 'Movies') {
          res = res.where((c) => c.contentType == 'movie').toList();
        } else if (_activeFilter == 'Series') {
          res = res.where((c) => c.contentType == 'series').toList();
        } else if (_activeFilter == 'Documentaries') {
          res = res.where((c) => c.contentType == 'documentary').toList();
        }
        _results = res;
      }
    });
  }

  void _applyFilter(String filter) {
    setState(() => _activeFilter = filter);
    _search(_ctrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      onChanged: _search,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Search movies, series...',
                        hintStyle:
                            TextStyle(color: AppTheme.textMuted, fontSize: 15),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: AppTheme.textMuted),
                        suffixIcon: _ctrl.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded,
                                    color: AppTheme.textMuted, size: 18),
                                onPressed: () {
                                  _ctrl.clear();
                                  _search('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((f) {
                        final isActive = _activeFilter == f;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => _applyFilter(f),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppTheme.primary
                                    : AppTheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                f,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                                  fontSize: 13,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Results
            Expanded(
              child: _isSearching
                  ? _results.isEmpty
                      ? _buildEmptyState()
                      : _buildResults()
                  : _buildBrowseAll(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, color: AppTheme.textMuted, size: 60),
          const SizedBox(height: 12),
          const Text('No results found',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
          const SizedBox(height: 4),
          Text('Try a different search term',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.62,
      ),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final c = _results[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(content: c)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: c.thumbnail,
              fit: BoxFit.cover,
              placeholder: (_, __) => Shimmer.fromColors(
                baseColor: AppTheme.surfaceVariant,
                highlightColor: AppTheme.surface,
                child: Container(color: AppTheme.surfaceVariant),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppTheme.surfaceVariant,
                child:
                    const Icon(Icons.movie_outlined, color: AppTheme.textMuted),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrowseAll() {
    final genres = [
      'Animation',
      'Sci-Fi',
      'Fantasy',
      'Drama',
      'Action',
      'Documentary',
      'Thriller'
    ];
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.6,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final colors = [
          [const Color(0xFFE50914), const Color(0xFF8B0000)],
          [const Color(0xFF1565C0), const Color(0xFF0D47A1)],
          [const Color(0xFF7B1FA2), const Color(0xFF4A148C)],
          [const Color(0xFF2E7D32), const Color(0xFF1B5E20)],
          [const Color(0xFFE65100), const Color(0xFFBF360C)],
          [const Color(0xFF00695C), const Color(0xFF004D40)],
          [const Color(0xFF37474F), const Color(0xFF263238)],
        ];
        return GestureDetector(
          onTap: () => _search(genres[index]),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors[index % colors.length],
              ),
            ),
            child: Center(
              child: Text(
                genres[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
