//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sebastian Olmos on 10/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("retweet did not succeed: \(error)")

        })
    }
    
    func setRetweeted(isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var likeButton: UIButton!
    var liked:Bool = false
    var tweetId:Int = -1
    
    @IBAction func likeTweet(_ sender: Any) {
        let tobeLiked = !liked
        if(tobeLiked){
            TwitterAPICaller.client?.likeTweet(tweetID: tweetId, success: {
                self.setLike(isLiked: true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetId, success: {
                self.setLike(isLiked: false)

            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")

            })
        }
    }
    
    
    func setLike(isLiked:Bool){
        liked = isLiked
        if(liked){
            likeButton.setImage(UIImage(named: "favor-icon-red"),for: UIControl.State.normal)
            
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"),for: UIControl.State.normal)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
