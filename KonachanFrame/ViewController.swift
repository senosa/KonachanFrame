//
//  ViewController.swift
//  KonachanFrame
//
//  Created by Sensuke Osawa on 2015/09/10.
//  Copyright (c) 2015年 Sensuke Osawa. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        let url = NSURL(string: "http://konachan.net/post.json?limit=1&tags=order%3Arandom")
        let req = NSURLRequest(URL: url!)
        var resp: NSURLResponse?
        var error: NSError?

        var data = NSURLConnection.sendSynchronousRequest(req, returningResponse: &resp, error: &error)
        if (error == nil) {
            var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &error) as! NSArray
            if (error == nil) {
                // ok
                let item = json[0] as! NSDictionary
                var jpegUrl = item.objectForKey("jpeg_url") as! String
                let img = NSImage(contentsOfURL: NSURL(string: jpegUrl)!)
                imageView.image = img
            } else {
                // json parse error
                println(error)
            }
        } else {
            // URL connection error
            println(error)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

