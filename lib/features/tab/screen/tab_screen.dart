import 'package:pixura_ai/features/tab/controller/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/features/auth/screen/auth_success_screen.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, this.initialIndex = 1});

  final int initialIndex;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<TabsController>(context, listen: false);
      int targetIndex = widget.initialIndex;
      controller.setCurrentTabIndex(index: targetIndex);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Sync profile when app comes to foreground
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.syncUserProfile(silent: true);
    }
  }

  final List<Widget> _screens = [
    const AuthSuccessScreen(),
    const Scaffold(body: Center(child: Text('Schedule Tab'))),
    const Scaffold(body: Center(child: Text('Accounts Tab'))),
    const Scaffold(body: Center(child: Text('Gallery Tab'))),
  ];

  Widget _getScreen(int index) {
    if (index >= 3) {
      return _screens[(index - 1).clamp(0, _screens.length - 1)];
    }
    return _screens[index.clamp(0, _screens.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabsController>(
      builder: (context, controller, child) => Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            _getScreen(controller.currentIndex),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.15),
                    width: 1.2,
                  ),
                ),
                child: GlassBottomBar(
                  verticalPadding: 0,
                  horizontalPadding: 0,
                  selectedIndex: controller.currentIndex.clamp(0, 4),
                  onTabSelected: (index) {
                    if (index == 2) {
                      _showCreateBottomSheet(context);
                    } else {
                      controller.setCurrentTabIndex(index: index);
                    }
                  },
                  interactionBehavior: GlassInteractionBehavior.full,
                  showIndicator: true,
                  selectedIconColor: Theme.of(context).colorScheme.onSurface,
                  unselectedIconColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.9),
                  labelFontSize: 10,
                  iconSize: 28,
                  iconLabelSpacing: 0,
                  indicatorColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.2),
                  quality: GlassQuality.premium,
                  settings: LiquidGlassSettings(
                    glassColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.15),
                    thickness: 30,
                    blur: 6,
                    chromaticAberration: .01,
                    lightAngle: GlassDefaults.lightAngle,
                    lightIntensity: .5,
                    ambientStrength: 0,
                    refractiveIndex: 1.2,
                    saturation: 1.2,
                    specularSharpness: GlassSpecularSharpness.medium,
                  ),
                  tabs: [
                    GlassBottomBarTab(
                      label: 'Home',
                      icon: Icon(Iconsax.home),
                      activeIcon: Icon(Iconsax.home),
                    ),
                    GlassBottomBarTab(
                      label: 'Schedule',
                      icon: Icon(Iconsax.calendar),
                      activeIcon: Icon(Iconsax.calendar),
                    ),
                    GlassBottomBarTab(
                      label: 'Create',
                      icon: _buildCustomCreateIcon(),
                      activeIcon: _buildCustomCreateIcon(),
                    ),
                    GlassBottomBarTab(
                      label: 'Accounts',
                      icon: Icon(Iconsax.people),
                      activeIcon: Icon(Iconsax.people),
                    ),
                    GlassBottomBarTab(
                      label: 'Gallery',
                      icon: Icon(Iconsax.gallery),
                      activeIcon: Icon(Iconsax.gallery),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildOptionItem(
                  icon: Iconsax.edit,
                  title: 'AI Post Writer',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AiPostWriterScreen(),
                    //   ),
                    // );
                  },
                ),
                SizedBox(height: 12.h),
                _buildOptionItem(
                  icon: Iconsax.image,
                  title: 'AI Image Studio',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AiImageStudioScreen(),
                    //   ),
                    // );
                  },
                ),
                SizedBox(height: 12.h),
                _buildOptionItem(
                  icon: Iconsax.video,
                  title: 'AI Video Generator',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AiVideoGeneratorScreen(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCreateIcon() {
    return Container(
      width: 48.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface, // Lime green/yellow
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
            offset: const Offset(0, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: 20.w,
          height: 20.h,
          child: CustomPaint(
            painter: SparklePainter(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class SparklePainter extends CustomPainter {
  final Color color;

  SparklePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    path.moveTo(cx, 0);
    path.quadraticBezierTo(cx, cy, w, cy);
    path.quadraticBezierTo(cx, cy, cx, h);
    path.quadraticBezierTo(cx, cy, 0, cy);
    path.quadraticBezierTo(cx, cy, cx, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
