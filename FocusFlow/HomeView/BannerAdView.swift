//
//  BannerAdView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI
import GoogleMobileAds

class AdsViewModel: ObservableObject {
    @Published var viewWidth: CGFloat = 0.0
}

struct BannerAdView: UIViewRepresentable {
    var adUnitID: String
    @Binding var viewWidth: CGFloat

    func makeUIView(context: Context) -> GADBannerView {
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        let bannerView = GADBannerView(adSize: adaptiveSize)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        bannerView.load(GADRequest())
        return bannerView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        uiView.adSize = adaptiveSize
    }
}

#Preview {
    BannerAdView(adUnitID: "123", viewWidth: .constant(250))
}
