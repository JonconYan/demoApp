//
//  SwiftVC.swift
//  demoApp
//
//  Created by xiaokangyan on 2022/8/25.
//

import Foundation
import UIKit

class SwiftVC : UIViewController,UITableViewDelegate,UITableViewDataSource {
    var btn: UIButton!
    var listView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn = UIButton()
        btn.backgroundColor = .red
        btn.frame = CGRect(origin:CGPoint(x: 50, y: self.view.frame.size.height/2),size: CGSize(width: 20,height: 20))
        self.view.addSubview(btn)
        
        listView = UITableView(frame: CGRectMake(50, 80, 100, 200), style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.register(listCell.self, forCellReuseIdentifier: "tableCell")
        listView.backgroundColor = .systemBlue
        self.view.addSubview(listView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : listCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! SwiftVC.listCell
        cell.textLabel?.text = "test";
        cell.cellLabel.text = "text";
        return cell
    }
    
    class listCell: UITableViewCell {
        var cellLabel : UILabel!
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            cellLabel = UILabel();
            cellLabel.textColor = .black;
            cellLabel.font = UIFont.systemFont(ofSize: 10);
            contentView.addSubview(cellLabel)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            cellLabel.frame = self.bounds;
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
