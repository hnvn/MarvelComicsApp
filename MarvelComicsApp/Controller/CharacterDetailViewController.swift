//
//  CharacterDetailViewController.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import UIKit
import WebKit

class CharacterDetailViewController: UIViewController {
    
    public var contentUrl: URL?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = contentUrl {
            webView.load(URLRequest(url: url))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
