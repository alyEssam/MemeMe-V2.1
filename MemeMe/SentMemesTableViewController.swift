//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Aly Essam on 7/7/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit

private let tableCellIdentifier = "memedCell"
private let detailedCellIdentifier = "DetailedCell"


class SentMemesTableViewController: UITableViewController {
    let memeCellHeight: CGFloat = 110.0
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView!.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! tableViewMemeCell
        cell.memeImage?.image = memes[indexPath.row].memedImage
        cell.memeText?.text = memes[indexPath.row].topText!  + "..." + memes[indexPath.row].bottomText!
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMemeController = self.storyboard!.instantiateViewController(withIdentifier: detailedCellIdentifier) as! DetailedCell
           detailMemeController.detailed = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailMemeController, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return memeCellHeight
    }

}
