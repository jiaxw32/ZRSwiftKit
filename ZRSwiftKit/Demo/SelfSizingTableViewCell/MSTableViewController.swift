//
//  MSTableViewController.swift
//  MSTabelViewDemo
//
//  Created by jiaxw-mac on 2017/8/28.
//  Copyright © 2017年 jiaxw-mac. All rights reserved.
//

import UIKit

let minTableViewHeaderOrFooterHeight: CGFloat = 0.1


class MSTableViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    var artisModelList = [ArtistModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView!.backgroundColor? = UIColor.white
        tableView!.separatorStyle = .none
        tableView.tableHeaderView = nil
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
//        self.automaticallyAdjustsScrollViewInsets = false

        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() -> Void {
//        artisModelList = ArtistHandler.loadData()
//        artisModelList = ArtistHandler.loadDataWithSwiftyJson()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            self.artisModelList = ArtistHandler.loadDataWithSwiftyJson()
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
            }
        }
    }

}

extension MSTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artisModelList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MSTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MSTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor? = .white
        cell.titleLabel.text = artisModelList[indexPath.row].name
        cell.bioLabel.text = artisModelList[indexPath.row].description
        cell.avatarImageView.image = UIImage(named: artisModelList[indexPath.row].avatar)
        return cell
    }
}

extension MSTableViewController:UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 64.0
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return minTableViewHeaderOrFooterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = artisModelList[indexPath.row]
        
        let alertController = UIAlertController(title: "title", message: "the artist name is " + artist.name, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController .addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

