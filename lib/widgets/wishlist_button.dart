import 'package:flutter/material.dart';
import 'package:first/services/api/wishlist_service.dart';
import 'package:first/services/user_session_manager.dart';

class WishlistButton extends StatefulWidget {
  final int wishlistId;
  final int variantId;

  const WishlistButton({
    super.key,
    required this.wishlistId,
    required this.variantId,
  });

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  final WishlistService _wishlistService = WishlistService();
  bool _isInWishlist = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  Future<void> _checkIfInWishlist() async {
    setState(() => _loading = true);
    try {
      final isInWishlist = await _wishlistService.isInWishlist(
        wishlistId: widget.wishlistId,
        variantId: widget.variantId,
      );
      setState(() => _isInWishlist = isInWishlist);
    } catch (e) {
      print('❌ Error checking wishlist: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _toggleWishlist() async {
    setState(() => _loading = true);
    try {
      final userId = UserSessionManager().userId;
      if (userId == null) {
        _showSnackBar('Please login first', Colors.red);
        setState(() => _loading = false);
        return;
      }

      bool success;
      if (_isInWishlist) {
        // Remove from wishlist
        success = await _wishlistService.removeFromWishlist(
          wishlistId: widget.wishlistId,
          variantId: widget.variantId,
        );
        if (success) {
          setState(() => _isInWishlist = false);
          _showSnackBar('🗑️ Removed from Wishlist', Colors.green);
        } else {
          _showSnackBar('Failed to remove from wishlist', Colors.red);
        }
      } else {
        // Add to wishlist (backend expects userId + variantId)
        success = await _wishlistService.addToWishlist(
          userId: userId,
          variantId: widget.variantId,
        );
        if (success) {
          setState(() => _isInWishlist = true);
          _showSnackBar('❤️ Added to Wishlist', Colors.green);
        } else {
          _showSnackBar('Failed to add to wishlist', Colors.red);
        }
      }
    } catch (e) {
      print('❌ Error toggling wishlist: $e');
      _showSnackBar('Failed to update wishlist', Colors.red);
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Icon(
              _isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isInWishlist ? Colors.red : Colors.black,
            ),
      onPressed: _loading ? null : _toggleWishlist,
    );
  }
}
