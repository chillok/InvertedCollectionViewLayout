//
//  ViewController.swift
//  SampleApp
//
//  Created by Cillian O'Keeffe on 23/06/2016.
//  Copyright © 2016 Cillian O'Keeffe. All rights reserved.
//

import UIKit
import InvertedCollectionViewLayout

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = InvertedCollectionViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellReuseIdentifier", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.label.text = "Cell \(indexPath.row)"
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return count
    }
}

extension ViewController: InvertedCollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, insetsForItemAtIndexPath indexPath: NSIndexPath) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
}
