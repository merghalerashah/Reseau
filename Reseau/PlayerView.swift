//
//  PlayerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//


import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update logic if needed
    }
}

struct PlayerView: View {
    @Binding var videos: [Video]
    let lifecycleDelegate: ViewLifecycleDelegate?

    var body: some View {
        VStack(spacing: 0) {
            ForEach(videos, id: \.id) { video in
                ZStack {
                    if let videoURLString = video.videoURL, let url = URL(string: videoURLString) {
                        Player(player: AVPlayer(url: url))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .offset(y: -5)
                    }
                    ReelInfoView(video: video)
                }
            }
        }
        .onAppear {
            self.lifecycleDelegate?.onAppear()
        }
        .onDisappear {
            self.lifecycleDelegate?.onDisappear()
        }
    }
}

struct PlayerPageView: UIViewRepresentable {
    @Binding var videos: [Video]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        let childView = UIHostingController(rootView: PlayerView(videos: $videos, lifecycleDelegate: context.coordinator))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(videos.count))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(videos.count))
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(videos.count))
        for i in 0..<uiView.subviews.count {
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(videos.count))
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate, ViewLifecycleDelegate {
        var parent: PlayerPageView
        var index = 0
        
        init(parent: PlayerPageView) {
            self.parent = parent
        }
        
        // ... Inside Coordinator class
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currentIndex {
                let currentVideo = parent.videos[index]
                let nextVideo = parent.videos[currentIndex]
                
                if let currentURLString = currentVideo.videoURL, let currentURL = URL(string: currentURLString),
                   let nextURLString = nextVideo.videoURL, let nextURL = URL(string: nextURLString) {
                    let currentPlayer = AVPlayer(url: currentURL)
                    let nextPlayer = AVPlayer(url: nextURL)
                    
                    currentPlayer.pause()
                    nextPlayer.play()
                    
                    index = currentIndex
                }
            }
        }
        
        func onAppear() {
            if let urlStr = parent.videos[index].videoURL, let url = URL(string: urlStr) {
                let player = AVPlayer(url: url)
                player.play()
            }
        }
        
        func onDisappear() {
            if let urlStr = parent.videos[index].videoURL, let url = URL(string: urlStr) {
                let player = AVPlayer(url: url)
                player.pause()
            }
        }
    }
}

protocol ViewLifecycleDelegate {
    func onAppear()
    func onDisappear()
}
