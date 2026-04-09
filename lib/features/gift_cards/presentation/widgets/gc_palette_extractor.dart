import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// Builder that extracts the dominant brand color from a CachedNetworkImage URL
/// and exposes it via a [ValueListenableBuilder]-style callback. Results are
/// memoized in a static cache so the second build for the same URL is free.
class GcPaletteExtractor extends StatefulWidget {
  const GcPaletteExtractor({
    super.key,
    required this.imageUrl,
    required this.fallback,
    required this.builder,
  });

  final String? imageUrl;
  final Color fallback;
  final Widget Function(BuildContext context, Color color) builder;

  static final Map<String, Color> _cache = {};
  static final Map<String, GcPaletteColors> _pairCache = {};

  /// Resolve the dominant brand color for an image URL. Returns the cached
  /// value when available, otherwise computes it via [PaletteGenerator] and
  /// caches the result. Falls back to [fallback] on any error or if the URL
  /// is null/empty.
  static Future<Color> resolve(String? url, Color fallback) async {
    if (url == null || url.isEmpty) return fallback;
    final cached = _cache[url];
    if (cached != null) return cached;
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(url),
        size: const Size(120, 120),
        maximumColorCount: 12,
      );
      final picked = palette.vibrantColor?.color ??
          palette.dominantColor?.color ??
          palette.lightVibrantColor?.color ??
          palette.darkVibrantColor?.color ??
          fallback;
      _cache[url] = picked;
      return picked;
    } catch (_) {
      return fallback;
    }
  }

  /// Resolve TWO complementary brand colors for an image URL. Returns
  /// `(primary, secondary)`. Used for cards that need a two-color glow.
  static Future<GcPaletteColors> resolvePair(
    String? url,
    GcPaletteColors fallback,
  ) async {
    if (url == null || url.isEmpty) return fallback;
    final cached = _pairCache[url];
    if (cached != null) return cached;
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(url),
        size: const Size(150, 150),
        maximumColorCount: 16,
      );
      final primary = palette.vibrantColor?.color ??
          palette.dominantColor?.color ??
          palette.lightVibrantColor?.color ??
          fallback.primary;
      final secondary = palette.darkVibrantColor?.color ??
          palette.mutedColor?.color ??
          palette.lightMutedColor?.color ??
          palette.darkMutedColor?.color ??
          (palette.lightVibrantColor?.color != primary
              ? palette.lightVibrantColor?.color
              : null) ??
          fallback.secondary;
      final pair = GcPaletteColors(primary: primary, secondary: secondary);
      _pairCache[url] = pair;
      return pair;
    } catch (_) {
      return fallback;
    }
  }

  @override
  State<GcPaletteExtractor> createState() => _GcPaletteExtractorState();
}

class _GcPaletteExtractorState extends State<GcPaletteExtractor> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = _initial();
    if (_color == widget.fallback) _resolve();
  }

  @override
  void didUpdateWidget(covariant GcPaletteExtractor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      setState(() => _color = _initial());
      if (_color == widget.fallback) _resolve();
    }
  }

  Color _initial() {
    final url = widget.imageUrl;
    if (url == null || url.isEmpty) return widget.fallback;
    return GcPaletteExtractor._cache[url] ?? widget.fallback;
  }

  Future<void> _resolve() async {
    final picked = await GcPaletteExtractor.resolve(
      widget.imageUrl,
      widget.fallback,
    );
    if (mounted) setState(() => _color = picked);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _color);
}

/// Pair of complementary colors extracted from a brand image.
class GcPaletteColors {
  const GcPaletteColors({required this.primary, required this.secondary});
  final Color primary;
  final Color secondary;
}

