//
//  CourseDetailViewController.swift
//  Video Course
//
//  Created by Rafayel Aghayan on 20.04.21.
//

import UIKit
import AVKit
import AVFoundation

class CourseDetailViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    var playerView = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playButton.clipsToBounds = true
        self.playButton.layer.cornerRadius = self.playButton.layer.frame.height / 2
    }
    
    func play() {
        let url : URL = URL(string: videoURL)!
        playerView = AVPlayer(url: url as URL)
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }
    
    @IBAction func playVideo(_ sender: Any) {
        play()
    }
}

