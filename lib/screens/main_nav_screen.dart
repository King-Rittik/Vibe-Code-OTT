import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kr_ott/core/theme.dart';
import 'package:kr_ott/screens/home_screen.dart';
import 'package:kr_ott/screens/search_screen.dart';
import 'package:kr_ott/screens/downloads_screen.dart';
import 'package:kr_ott/screens/profile_screen.dart';

// Responsive breakpoints
const double _kTabletBreak = 600.0;
const double _kDesktopBreak = 1024.0;

class _NavDestination {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavDestination({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

const _destinations = [
  _NavDestination(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  _NavDestination(
    icon: Icons.search_rounded,
    activeIcon: Icons.search_rounded,
    label: 'Search',
  ),
  _NavDestination(
    icon: Icons.download_outlined,
    activeIcon: Icons.download_rounded,
    label: 'Downloads',
  ),
  _NavDestination(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    SearchScreen(),
    DownloadsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0F0F0F),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  void _onNavTap(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= _kTabletBreak;
    final isDesktop = width >= _kDesktopBreak;

    if (isDesktop)
      return _DesktopLayout(
        screens: _screens,
        currentIndex: _currentIndex,
        onNavTap: _onNavTap,
      );
    if (isTablet)
      return _TabletLayout(
        screens: _screens,
        currentIndex: _currentIndex,
        onNavTap: _onNavTap,
      );
    return _PhoneLayout(
      screens: _screens,
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Phone  →  Bottom navigation bar
// ─────────────────────────────────────────────────────────────────────────────
class _PhoneLayout extends StatelessWidget {
  final List<Widget> screens;
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const _PhoneLayout({
    required this.screens,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: _BottomBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tablet  →  Rail (icon-only sidebar)
// ─────────────────────────────────────────────────────────────────────────────
class _TabletLayout extends StatelessWidget {
  final List<Widget> screens;
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const _TabletLayout({
    required this.screens,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Row(
        children: [
          _SideRail(
            currentIndex: currentIndex,
            onTap: onNavTap,
            expanded: false,
          ),
          const VerticalDivider(width: 0.5, color: AppTheme.divider),
          Expanded(
            child: IndexedStack(index: currentIndex, children: screens),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Desktop  →  Expanded sidebar with labels + logo
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final List<Widget> screens;
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const _DesktopLayout({
    required this.screens,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Row(
        children: [
          _SideRail(
            currentIndex: currentIndex,
            onTap: onNavTap,
            expanded: true,
          ),
          const VerticalDivider(width: 0.5, color: AppTheme.divider),
          Expanded(
            child: IndexedStack(index: currentIndex, children: screens),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Side Rail  (shared by tablet + desktop)
// ─────────────────────────────────────────────────────────────────────────────
class _SideRail extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool expanded; // false = icon-only rail, true = icon + label

  const _SideRail({
    required this.currentIndex,
    required this.onTap,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final railWidth = expanded ? 220.0 : 72.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: railWidth,
      color: const Color(0xFF0F0F0F),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Padding(
              padding: EdgeInsets.fromLTRB(
                expanded ? 20 : 0,
                24,
                20,
                24,
              ),
              child: expanded
                  ? RichText(
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
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppTheme.primary, Color(0xFF8B0000)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'KR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            // Nav items
            ...List.generate(_destinations.length, (i) {
              final dest = _destinations[i];
              final isActive = currentIndex == i;
              return _RailItem(
                icon: dest.icon,
                activeIcon: dest.activeIcon,
                label: dest.label,
                isActive: isActive,
                expanded: expanded,
                onTap: () => onTap(i),
              );
            }),
            const Spacer(),
            // Bottom hint
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  'KRstream v1.0',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RailItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final bool expanded;
  final VoidCallback onTap;

  const _RailItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(
          horizontal: expanded ? 12 : 8,
          vertical: 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: expanded ? 14 : 0,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withOpacity(0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: AppTheme.primary.withOpacity(0.25), width: 0.5)
              : null,
        ),
        child: expanded
            ? Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isActive ? activeIcon : icon,
                      key: ValueKey(isActive),
                      color: isActive ? AppTheme.primary : AppTheme.textMuted,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color:
                          isActive ? AppTheme.primary : AppTheme.textSecondary,
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                    ),
                    child: Text(label),
                  ),
                  if (isActive) ...[
                    const Spacer(),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              )
            : Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? activeIcon : icon,
                    key: ValueKey(isActive),
                    color: isActive ? AppTheme.primary : AppTheme.textMuted,
                    size: 26,
                  ),
                ),
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Bar  (phone only)
// ─────────────────────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        border: Border(
          top: BorderSide(color: AppTheme.divider, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_destinations.length, (i) {
              final dest = _destinations[i];
              final isActive = currentIndex == i;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppTheme.primary.withOpacity(0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isActive ? dest.activeIcon : dest.icon,
                          key: ValueKey(isActive),
                          color: isActive
                              ? AppTheme.primary
                              : const Color(0xFF6B6B6B),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 3),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isActive
                              ? AppTheme.primary
                              : const Color(0xFF6B6B6B),
                          fontSize: 11,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: Text(dest.label),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
