import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sudoku_classic/app/modules/game/controllers/game_controller.dart';

class AdsController extends GetxController {
  late int numberOfGamePlayed;
  // ProfileController profileController = Get.find<ProfileController>();
  // late GameController gameController ;
  bool isHomePageBannerLoaded = false;
  late BannerAd homePageBanner;

  bool isnativeAdLoaded = false;
  late NativeAd nativeAd;

  bool isInterstitialAdLoaded = false;
  late InterstitialAd interstitialAd;
  bool isRewardedAdLoaded = false;
  RewardedAd? rewardedAdContent;

  @override
  void onInit() {
    numberOfGamePlayed = 0;
    initializeFullPageAd();
    initializeHomePageBanner();
    createRewardedAd();
    super.onInit();
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAd(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            log('$ad loaded.');
            // _rewardedAd = ad;
            // _numRewardedLoadAttempts = 0;
            rewardedAdContent = ad;
            isRewardedAdLoaded = true;
            // update(['ads']);
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            isRewardedAdLoaded = false;
            // update(['ads']);
            // createRewardedAd();
          },
        ));
  }

  void showRewardedAd(
      {required bool isForHint, required GameController controller}) {
    if (isRewardedAdLoaded == false) {
      log('Warning: attempt to show rewarded before loaded.');
      createRewardedAd();
    }

    rewardedAdContent!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();

        update(['ads']);
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
        update(['ads']);
      },
    );

    rewardedAdContent!.setImmersiveMode(true);
    rewardedAdContent!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      // profileController.user = profileController.user.copyWith(
      //   availableHint: profileController.user.availableHint + 10,
      //   score: profileController.user.score + 30,
      // );
      // isForHint
      //     ?
      //     : profileController.user.copyWith(

      //         score: profileController.user.score + 30,
      //       );

      if (isForHint) {
        controller.profileController.user =
            controller.profileController.user.copyWith(
          availableHint: controller.profileController.user.availableHint + 10,
        );
        controller.profileController.update(['hint']);
      } else {
        controller.lifeRemain.value += 2;
      }
      update(['ads']);

      createRewardedAd();
    });
    rewardedAdContent = null;
  }

  void initializeHomePageBanner() async {
    homePageBanner = BannerAd(
      adUnitId: AdHelper.playBanner(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        log('PlayPage Banner Loaded!');
        isHomePageBannerLoaded = true;
        update(['ads']);
      }, onAdClosed: (ad) {
        ad.dispose();
        isHomePageBannerLoaded = false;
        initializeHomePageBanner();
      }, onAdFailedToLoad: (ad, err) {
        log(err.toString());
        isHomePageBannerLoaded = false;
        // initializeHomePageBanner();
      }),
    );

    await homePageBanner.load();
    update(['ads']);

    // notifyListeners();
  }

  void initializeFullPageAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstialAd(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        log('Full Page Ad Loaded!');
        interstitialAd = ad;
        isInterstitialAdLoaded = true;
        update(['ads']);
      }, onAdFailedToLoad: (err) {
        log(err.toString());
        isInterstitialAdLoaded = false;
        update(['ads']);
      }),
    );

    // notifyListeners();
  }
}

// ignore: avoid_classes_with_only_static_members
class AdHelper {
  static String playBanner() {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-3940256099942544/6300978111';
      return kDebugMode
          ? '	ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3404733564908964/5038894407';
    } else {
      return '';
    }
  }

  static String interstialAd() {
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3404733564908964/8786567727';
    } else {
      return '';
    }
  }

  static String rewardedAd() {
    if (Platform.isAndroid) {
      return kDebugMode
          ? '	ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3404733564908964/3366682096';
    } else {
      return '';
    }
  }

  static String nativeAd() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3404733564908964/2412731061';
    } else {
      return '';
    }
  }
}
