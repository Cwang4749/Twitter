//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by JC on 2/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var TweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    var rCount:Int = -1
    var fCount:Int = -1
    
    func setCount(_ label:UILabel, counter:Int)
    {
        if(label == retweetCount)
        {
            rCount = counter
        }
        else
        {
            fCount = counter
        }
        label.text = "\(counter)"
        if(counter > 1000)
        {
            let newCount = Float(counter / 1000)
            label.text = "\(newCount)K"
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
    
    func setFav(_ isFavorited:Bool)
    {
        favorited = isFavorited
        if(favorited)
        {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            fCount += 1
            setCount(favCount, counter: fCount)
        }
        else
        {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            fCount -= 1
            setCount(favCount, counter: fCount)
        }
    }
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited)
        {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFav(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        }
        else
        {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFav(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        /*
        TwitterAPICaller.client?.rewtweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        })*/
        
        
        let toBeRetweeted = !retweeted
        if(toBeRetweeted)
        {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (Error) in
                print("Retweet did not succeed: \(Error)")
            })
        }
        else
        {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (Error) in
                print("Unretweet did not succeed \(Error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool)
    {
        retweeted = isRetweeted
        if(retweeted)
        {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false
            
            rCount += 1
            setCount(retweetCount, counter: rCount)
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true
            
            rCount -= 1
            setCount(retweetCount, counter: rCount)
        }
    }
}
