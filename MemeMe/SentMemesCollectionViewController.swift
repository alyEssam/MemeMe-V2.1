//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Aly Essam on 7/7/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit



private let collectionCellIdentifier = "memedCell"
private let detailedCellIdentifier = "DetailedCell"

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimensionPortrait = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionPortrait, height: dimensionPortrait)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionView!.reloadData()
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! CollectionViewMemeCell
        
        // Configure the cell
        cell.memedImage.image = memes[indexPath.item].memedImage
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailMemeController = self.storyboard?.instantiateViewController(withIdentifier: detailedCellIdentifier) as! DetailedCell
        detailMemeController.detailed = self.memes[indexPath.item]        
        self.navigationController!.pushViewController(detailMemeController, animated: true)
    }
}
