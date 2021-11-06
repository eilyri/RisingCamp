//
//  NewsTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var evaluationImage: UIImageView!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var areaInfoLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    var pictureString = ""
    var reviewPictures = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        pictureCollectionView.register(UINib(nibName: "PictureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PictureCollectionViewCell")
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: pictureCollectionView.frame.width - 24, height: pictureCollectionView.frame.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        pictureCollectionView.collectionViewLayout = flowLayout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewPictures = pictureString.components(separatedBy: ",")
        pageLabel.text = "1/" + String(reviewPictures.count)
        pageView.alpha = 1
        if reviewPictures.count == 1 {
            pageView.alpha = 0
        }
        return reviewPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
        
        if reviewPictures.count > 0 {
            let url = URL(string: reviewPictures[indexPath.row])
            let data = try? Data(contentsOf: url!)
            cell.foodPictureImage.image = UIImage(data: data!)
        }
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == pictureCollectionView {
            let page = Int(targetContentOffset.pointee.x / self.pictureCollectionView.bounds.width)
            
            pageLabel.text = String(page+1) + "/" + String(reviewPictures.count)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
    }
    
}
