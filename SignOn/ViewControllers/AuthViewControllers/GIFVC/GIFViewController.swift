//
//  GIFViewController.swift
//  SignOn
//
//  Created by Callsoft on 18/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class GIFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let jeremyGif = UIImage.gifImageWithName(name: "loadingeffect")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(imageView)
    }
    


}
