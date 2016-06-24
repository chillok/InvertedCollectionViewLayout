# InvertedCollectionViewLayout

Simple UICollectionViewLayout subclass that lays out cells from bottom to top, displaying initially the bottom cell.

![](http://i.imgur.com/bUKnIAB.png)


### Usage:

In your UIViewController: 

1 - Set the Layout on the UICollectionView.

```
let layout = InvertedCollectionViewLayout()
layout.delegate = self
collectionView.setCollectionViewLayout(layout, animated: false)
```

2 - Implement the InvertedCollectionViewLayoutDelegate:

```

extension ViewController: InvertedCollectionViewLayoutDelegate {
    
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func insets(indexPath: NSIndexPath) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
```
