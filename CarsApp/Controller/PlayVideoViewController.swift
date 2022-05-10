//
//  PlayVideoViewController.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import UIKit
import AVFoundation

class PlayVideoViewController: UIViewController	 {

    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "url of the audio or video")
             playerItem = AVPlayerItem(URL: url!)
             player=AVPlayer(playerItem: playerItem!)
             let playerLayer=AVPlayerLayer(player: player!)
             playerLayer.frame=CGRectMake(0, 0, 300, 50)
             self.view.layer.addSublayer(playerLayer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
