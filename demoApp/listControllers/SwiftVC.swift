//
//  SwiftVC.swift
//  demoApp
//
//  Created by xiaokangyan on 2022/8/25.
//

import Foundation
import UIKit

class SwiftVC : UIViewController {
    var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn = UIButton()
        btn.backgroundColor = .red
        btn.frame = CGRect(origin:CGPoint(x: 50, y: self.view.frame.size.height/2),size: CGSize(width: 20,height: 20))
        self.view.addSubview(btn)
    }
}
