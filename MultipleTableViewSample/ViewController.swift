//
//  ViewController.swift
//  MultipleTableViewSample
//
//  Created by Naoto Saida on 2019/01/01.
//  Copyright © 2019 naoto-saida. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView0: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    // 表示用データ
    var items0: NSMutableArray = ["ねずみ", "うし", "とら", "うさぎ"]
    var items1: NSMutableArray = ["りゅう", "へび", "うま", "ひつじ", "さる", "とり"]
    var items2: NSMutableArray = ["いぬ", "いのしし"]
    var items: [NSMutableArray] = []
    
    // 処理分岐用
    var tag:Int = 0
    var cellIdentifier:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        tableView0.delegate = self
        tableView0.dataSource = self
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        
        // 表示用データの配列を配列にする
        items.append(items0)
        items.append(items1)
        items.append(items2)
    }
    
    // 処理を分岐するメソッド
    func checkTableView(_ tableView: UITableView) -> Void{
        if (tableView.tag == 0) {
            tag = 0
            cellIdentifier = "cellIdentifier0"
        }
        else if (tableView.tag == 1) {
            tag = 1
            cellIdentifier = "cellIdentifier1"
        }
        else {
            tag = 2
            cellIdentifier = "cellIdentifier2"
        }
    }
    
    // MARK: - テーブルビュー
    // セルの数を返す。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkTableView(tableView)
        
        return items[tag].count
    }
    
    // セルを返す。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkTableView(tableView)
        
        // セルにテキストを出力する。
        let cell = tableView.dequeueReusableCell(withIdentifier:  cellIdentifier, for:indexPath as IndexPath)
        cell.textLabel?.text = items[tag][indexPath.row] as? String
        
        return cell
    }
    
    // テーブルビューをスワイプしてデータを削除する。
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            self.checkTableView(tableView)
            self.items[self.tag].removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
        
    }
}

