//
//  RestaurantViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/19.
//

import UIKit

class RestaurantViewController: BaseViewController {

    var restaurantId: Int = 0
    var reviewData: [ReviewResult] = []
    
    @IBOutlet weak var informationLastUpdate: UILabel!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var holidayLabel: UILabel!
    @IBOutlet weak var priceInfoLabel: UILabel!
    
    var menuList: [String] = []
    var priceList: [String] = []
    
    @IBOutlet weak var menuUpdateLabel: UILabel!
    @IBOutlet weak var menu1Label: UILabel!
    @IBOutlet weak var menu2Label: UILabel!
    @IBOutlet weak var menu3Label: UILabel!
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var foodPictureCollectionView: UICollectionView!
    @IBOutlet weak var topBar: UIView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var downButton: UIButton!
    @IBAction func downButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var mapButtonView: UIView!
    @IBOutlet weak var ItemView: UIView!
    
    private let myWannagoButton: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 0, y: 9, width: 80, height: 32))
        //button.backgroundColor = .mainLightGray
        return button
    }()
    private let myDidgoButton: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myReviewButton: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myListButton: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 4, y: 9, width: 80, height: 32))
        return button
    }()
    
    private let myWannagoButton2: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        //button.backgroundColor = .mainLightGray
        return button
    }()
    private let myDidgoButton2: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myReviewButton2: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myListButton2: ResCustomButton = {
        let button = ResCustomButton(frame: CGRect(x: 4, y: 9, width: 80, height: 32))
        return button
    }()
    
    private let myFindwayButton: MapCustomButton = {
        let button = MapCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        //button.backgroundColor = .mainLightGray
        return button
    }()
    private let myNaviButton: MapCustomButton = {
        let button = MapCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myTaxiButton: MapCustomButton = {
        let button = MapCustomButton(frame: CGRect(x: 30, y: 9, width: 80, height: 32))
        return button
    }()
    private let myCopyButton: MapCustomButton = {
        let button = MapCustomButton(frame: CGRect(x: 4, y: 9, width: 80, height: 32))
        return button
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var lotaddressLabel: UILabel!
    
    var imageString: String = ""
    var imageList: [String] = []
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReviewDataManager().getReview(id: restaurantId, viewController: self)
        
        myScrollView.delegate = self
        // Do any additional setup after loading the view.
        buttonView.isHidden = true
        
        downButton.setImage(UIImage(named: "downbutton")?.withRenderingMode(.alwaysTemplate), for: .normal)
        downButton.tintColor = .mainOrange
        //cameraButton.setImage(UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate), for: .normal)
        //shareButton.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cameraButton.tintColor = .mainOrange
        shareButton.tintColor = .mainOrange
        
        addButtons()
        
        foodPictureCollectionView.delegate = self
        foodPictureCollectionView.dataSource = self
        foodPictureCollectionView.register(UINib(nibName: "RestaurantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        reviewTableView.register(UINib(nibName: "ReviewTabTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTabTableViewCell")
        reviewTableView.backgroundColor = UIColor(hex: 0xeeeeee)
        reviewTableView.separatorStyle = .none
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.invalidateIntrinsicContentSize()
        self.reviewTableView.layoutIfNeeded()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        RestaurantDetailDataManager().getRestaurantDetail(id: restaurantId, viewController: self)
        reviewTableView.invalidateIntrinsicContentSize()
        self.reviewTableView.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewHeight.constant = self.reviewTableView.contentSize.height
        reviewTableView.reloadData()
    }
    
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTabTableViewCell", for: indexPath) as! ReviewTabTableViewCell
            cell.titleLabel.text = "주요 리뷰 (\(reviewData.count))"
            var deliciousCount = 0
            var goodCount = 0
            var badCount = 0
            if reviewData.count > 0 {
                for i in 0...(reviewData.count - 1) {
                    if reviewData[i].evaluation == "맛있다!"{
                        deliciousCount += 1
                    }
                    else if reviewData[i].evaluation == "괜찮다" {
                        goodCount += 1
                    }
                    else if reviewData[i].evaluation == "별로" {
                        badCount += 1
                    }
                }
            }
            
            cell.deliciousLabel.text = "맛있다! (\(String(deliciousCount)))"
            cell.goodLabel.text = "괜찮다 (\(String(goodCount)))"
            cell.badLabel.text = "별로 (\(String(badCount)))"
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.selectionStyle = .none
        let url = URL(string: reviewData[indexPath.row - 1].profileImage!)
        let data = try? Data(contentsOf: url!)
        cell.profileImage.image = UIImage(data: data!)
        
        cell.nicknameLabel.text = reviewData[indexPath.row - 1].nickname
        cell.imageString = reviewData[indexPath.row - 1].reviewImage ?? ""
        cell.reviewCountLabel.text = String(reviewData[indexPath.row - 1].reviewCount!)
        cell.followerCountLabel.text = String(reviewData[indexPath.row - 1].followerCount!)
        cell.evaluationImage.image = UIImage(named: reviewData[indexPath.row - 1].evaluation!)
        cell.evaluationLabel.text = reviewData[indexPath.row - 1].evaluation
        cell.reviewLabel.text = reviewData[indexPath.row - 1].content
        cell.reviewLabel.sizeToFit()
        cell.likeCountLabel.text = String(reviewData[indexPath.row - 1].likeCount!)
        cell.commentCountLabel.text = String(reviewData[indexPath.row - 1].commentCount!)
        cell.dateLabel.text = reviewData[indexPath.row - 1].date
        
        return cell
    }
    
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageString != "" {
            return imageList.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        
        if imageString != "" {
            if indexPath.row < imageList.count && imageList[indexPath.row] != "" {
                let url = URL(string: imageList[indexPath.row])
                let data = try? Data(contentsOf: url!)
                cell.restaurantImageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    
}

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == myScrollView {
            if scrollView.contentOffset.y >= 237 {
                buttonView.isHidden = false
                cameraButton.tintColor = .white
                shareButton.tintColor = .white
                downButton.tintColor = .white
                topBar.alpha = 0
            }
            else {
                buttonView.isHidden = true
            }
            
            if scrollView.contentOffset.y >= 150 {
                topBar.alpha = 1 - (scrollView.contentOffset.y - 150) / 87
            }
            else {
                topBar.alpha = 1
                downButton.tintColor = .mainOrange
                cameraButton.tintColor = .mainOrange
                shareButton.tintColor = .mainOrange
                topBar.tintColor = .mainOrange
            }
        }
    }
}

// MARK: API Functions
extension RestaurantViewController {
    
    func didRetrieveReview(_ result: [ReviewResult]) {
        self.dismissIndicator()
        reviewData = result
        
        reviewTableView.reloadData()
    }
    func didRetrieveRestaurantDetail(_ result: [DetailResult]){
        self.dismissIndicator()
        titleLabel.text = result[0].name
        nameLabel.text = result[0].name
        ratingLabel.text = result[0].rating
        viewsLabel.text = String(result[0].views ?? 0)
        reviewsLabel.text = String(result[0].reviews ?? 0)
        starCountLabel.text = String(result[0].starCount ?? 0)
        addressLabel.text = result[0].roadNameAddress
        lotaddressLabel.text = result[0].lotNumberAddress
        imageString = result[0].imageUrl ?? ""
        imageList = imageString.components(separatedBy: ",")
        informationLastUpdate.text = "마지막 업데이트: \(result[0].infoUpdate!)"
        businessLabel.text = result[0].businessHour
        holidayLabel.text = result[0].holiday
        priceInfoLabel.text = result[0].priceInfo
        menuUpdateLabel.text = result[0].menuUpdate
        menuList = (result[0].menu?.components(separatedBy: "/")) ?? []
        priceList = (result[0].price?.components(separatedBy: "/")) ?? []
        
        if menuList.count != 0 {
            menu1Label.text = menuList[0]
            menu2Label.text = menuList[1]
            menu3Label.text = menuList[2]
        }
        if priceList.count != 0 {
            price1Label.text = priceList[0]
            price2Label.text = priceList[1]
            price3Label.text = priceList[2]
        }
       
        foodPictureCollectionView.reloadData()
        reviewTableView.invalidateIntrinsicContentSize()
        self.reviewTableView.layoutIfNeeded()
    }
    
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
    
    func addButtons() {
        ItemView.addSubview(myWannagoButton)
        buttonView.addSubview(myWannagoButton2)
        myWannagoButton.frame = CGRect(x: ItemView.frame.width / 4 - myWannagoButton.frame.width / 1.1, y: 9, width: 0, height: 0)
        myWannagoButton2.frame = CGRect(x: buttonView.frame.width / 4 - myWannagoButton2.frame.width / 1.1, y: 9, width: 0, height: 0)
        let viewModel = ResCustomButtonViewModel(imageName: "bigstar", title: "가고싶다", titleColor: .mainOrange)
        myWannagoButton.configure(with: viewModel)
        myWannagoButton2.configure(with: viewModel)
        
        ItemView.addSubview(myDidgoButton)
        buttonView.addSubview(myDidgoButton2)
        myDidgoButton.frame = CGRect(x: ItemView.frame.width / 2 - myDidgoButton.frame.width / 1.1, y: 9, width: 0, height: 0)
        myDidgoButton2.frame = CGRect(x: buttonView.frame.width / 2 - myDidgoButton2.frame.width / 1.1, y: 9, width: 0, height: 0)
        let viewModel2 = ResCustomButtonViewModel(imageName: "placemark", title: "가봤어요", titleColor: .mainOrange)
        myDidgoButton.configure(with: viewModel2)
        myDidgoButton2.configure(with: viewModel2)
        
        ItemView.addSubview(myReviewButton)
        buttonView.addSubview(myReviewButton2)
        myReviewButton.frame = CGRect(x: ItemView.frame.width / 4 * 3 - myReviewButton.frame.width / 1.1, y: 9, width: 0, height: 0)
        myReviewButton2.frame = CGRect(x: buttonView.frame.width / 4 * 3 - myReviewButton2.frame.width / 1.1, y: 9, width: 0, height: 0)
        let viewModel3 = ResCustomButtonViewModel(imageName: "review", title: "리뷰쓰기", titleColor: .mainOrange)
        myReviewButton.configure(with: viewModel3)
        myReviewButton2.configure(with: viewModel3)
        
        ItemView.addSubview(myListButton)
        buttonView.addSubview(myListButton2)
        myListButton.frame = CGRect(x: ItemView.frame.width - myListButton.frame.width, y: 9, width: 0, height: 0)
        myListButton2.frame = CGRect(x: buttonView.frame.width - myListButton2.frame.width, y: 9, width: 0, height: 0)
        let viewModel4 = ResCustomButtonViewModel(imageName: "mylist", title: "마이리스트", titleColor: .mainOrange)
        myListButton.configure(with: viewModel4)
        myListButton2.configure(with: viewModel4)
        
        mapButtonView.addSubview(myFindwayButton)
        myFindwayButton.frame = CGRect(x: mapButtonView.frame.width / 4 - myFindwayButton.frame.width / 1.4, y: 20, width: 0, height: 0)
        let viewModel5 = MapCustomButtonViewModel(imageName: "findway", title: "길 찾기")
        myFindwayButton.configure(with: viewModel5)
        
        mapButtonView.addSubview(myNaviButton)
        myNaviButton.frame = CGRect(x: mapButtonView.frame.width / 2 - myNaviButton.frame.width / 1.05, y: 20, width: 0, height: 0)
        let viewModel6 = MapCustomButtonViewModel(imageName: "navi", title: "내비게이션")
        myNaviButton.configure(with: viewModel6)
        
        mapButtonView.addSubview(myTaxiButton)
        myTaxiButton.frame = CGRect(x: mapButtonView.frame.width / 4 * 3 - myTaxiButton.frame.width, y: 20, width: 0, height: 0)
        let viewModel7 = MapCustomButtonViewModel(imageName: "taxi", title: "택시부르기")
        myTaxiButton.configure(with: viewModel7)
        
        mapButtonView.addSubview(myCopyButton)
        myCopyButton.frame = CGRect(x: mapButtonView.frame.width - myCopyButton.frame.width / 0.9, y: 20, width: 0, height: 0)
        let viewModel8 = MapCustomButtonViewModel(imageName: "copy", title: "주소 복사")
        myCopyButton.configure(with: viewModel8)
    }

}
