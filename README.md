# InvertedCollectionViewLayout 

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Simple UICollectionViewLayout subclass that lays out cells from bottom to top, displaying initially the bottom cell.

![](http://i.imgur.com/bUKnIAB.png)


### Usage:

In your UIViewController: 

1 - Set the Layout on the UICollectionView.

```swift
let layout = InvertedCollectionViewLayout()

layout.delegate = self

collectionView.setCollectionViewLayout(layout, animated: false)
```

2 - Implement the InvertedCollectionViewLayoutDelegate:

```swift
extension ViewController: InvertedCollectionViewLayoutDelegate {
    
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func insets(indexPath: NSIndexPath) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
```
