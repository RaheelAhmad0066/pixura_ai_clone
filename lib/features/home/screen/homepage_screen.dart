import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  Map<String, String>? _selectedItem;

  final List<Map<String, String>> _leftColumnItems = [
    {
      'title': 'Vintage Ride',
      'description': 'A classic yellow car parked elegantly in front of a minimalist building facade.',
      'image': AssetsConstants.illustration3,
      'tag': 'vintage',
    },
    {
      'title': 'Balanced Stones',
      'description': 'A beautiful stack of rocks balanced carefully against a cool gradient sky.',
      'image': AssetsConstants.illustration5,
      'tag': 'nature',
    },
    {
      'title': 'Street Hoop',
      'description': 'A basketball player caught mid-air performing a slam dunk at dusk.',
      'image': AssetsConstants.illustration6,
      'tag': 'sports',
    },
  ];

  final List<Map<String, String>> _rightColumnItems = [
    {
      'title': 'Dreamy Eyes',
      'description': 'A close-up portrait of a woman looking up, lost in thought under soft blue light.',
      'image': AssetsConstants.illustration4,
      'tag': 'portrait',
    },
    {
      'title': 'Avant-Garde Runway Model',
      'description':
          'Model in yellow jumpsuit with oversized pockets, red glossy headpiece, and white visor on a runway with blurred audience.',
      'image': AssetsConstants.illustration12,
      'tag': 'runway',
    },
    {
      'title': 'Crimson Shadow',
      'description': 'A high-contrast fashion portrait of a woman wearing a wide-brimmed crimson red hat.',
      'image': AssetsConstants.illustration7,
      'tag': 'fashion',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Grid Feed
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 100.h, // Space for floating tab bar
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      children: _leftColumnItems
                          .map((item) => _buildGridCard(item))
                          .toList(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Right Column
                  Expanded(
                    child: Column(
                      children: _rightColumnItems
                          .map((item) => _buildGridCard(item))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Fullscreen detail view overlay
          if (_selectedItem != null)
            _buildFullscreenDetailOverlay(_selectedItem!),
        ],
      ),
    );
  }

  Widget _buildGridCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem = item;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            item['image']!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFullscreenDetailOverlay(Map<String, String> item) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Selected fullscreen image
          Image.asset(
            item['image']!,
            fit: BoxFit.cover,
          ),

          // Dark gradient overlay for text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Top Header (Back button + share)
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button in semi-transparent circle
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItem = null;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                // Options Icon in circle
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          // Right vertical toolbar icons
          Positioned(
            right: 20.w,
            top: 220.h,
            child: Column(
              children: [
                _buildToolbarButton(Icons.favorite_border),
                SizedBox(height: 16.h),
                _buildToolbarButton(Icons.mode_comment_outlined),
                SizedBox(height: 16.h),
                _buildToolbarButton(Icons.share_outlined),
                SizedBox(height: 16.h),
                _buildToolbarButton(Icons.add_circle_outline),
              ],
            ),
          ),

          // Bottom Content Details (Title, Description, and Tag)
          Positioned(
            bottom: 130.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Mustard-colored tag chip
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mustard,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        item['tag']!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  item['description']!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Bottom floating actions (Dots & Download)
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              children: [
                // Three dots action button
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Download action button
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.35),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
