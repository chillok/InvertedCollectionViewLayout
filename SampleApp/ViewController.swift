//
//  ViewController.swift
//  SampleApp
//
//  Created by Cillian O'Keeffe on 23/06/2016.
//  Copyright © 2016 Cillian O'Keeffe. All rights reserved.
//

import UIKit
import InvertedCollectionViewLayout

class Context: UICollectionViewLayoutInvalidationContext {
    
    override var invalidateDataSourceCounts: Bool {
        return true
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var count = Array(0.stride(through: 10, by: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = InvertedCollectionViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    @IBAction func add() {
        
        self.count.insert(count[0]-1, atIndex: 0)
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        self.collectionView.insertItemsAtIndexPaths([indexPath])
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellReuseIdentifier", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.label.text = "Cell \(count[indexPath.row])"
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(count)
        
        return count.count
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
