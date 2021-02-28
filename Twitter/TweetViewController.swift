//
//  TweetViewController.swift
//  Twitter
//
//  Created by JC on 2/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        
        //Displays keyboard and cursor for user
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty)
        {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //character count:
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length + range.location > tweetTextView.text.count
        {
            return false
        }
        
        let new = tweetTextView.text.count + text.count - range.length
        changeCount(new)
        return new <= 280
    }
    
    func changeCount(_ counter:Int)
    {
        if counter <= 280
        {
            charCountLabel.text = "\(280 - counter) Characters Left"
        }
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
