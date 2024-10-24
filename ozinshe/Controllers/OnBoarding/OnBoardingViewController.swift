//
//  OnBoardingViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 22.10.2024.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Private properties
    private let slidesArray: [[String]] = [
        ["firstSlide", "ÖZINŞE-ге қош келдің!", "Фильмдер, телехикаялар, ситкомдар,\n анимациялық жобалар, телебағдарламалар\n мен реалити-шоулар, аниме және тағы\n басқалары"],
        ["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара\n          Сүйікті фильміңді  қосымша төлемсіз\n телефоннан, планшеттен, ноутбуктан қара"],
        ["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған\n фильміңе қол жеткіз"]
    ]
    
    //CollectionView
    private var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slidesCell", for: indexPath) as! SlidesCollectionViewCell
        
        cell.configure(
            image: UIImage(named: slidesArray[indexPath.row][0])!,
            titleText: slidesArray[indexPath.row][1],
            descriptionText: slidesArray[indexPath.row][2]
        )
        
        if indexPath.row != 2{
            cell.skipButton.isHidden = false
            cell.nextButton.isHidden = true
        } else{
            cell.skipButton.isHidden = true
            cell.nextButton.isHidden = false
        }
        
        cell.skipButton.addTarget(self, action: #selector(goToSingIn), for: .touchUpInside)
        
        cell.nextButton.addTarget(self, action: #selector(goToSingIn), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    private var currentPage = 0 {
        didSet{
            updatePageControlUI(currentPageIndex: currentPage)
            pageControl.currentPage = currentPage
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.pageIndicatorTintColor = UIColor(.pageControl)
        pageControl.currentPageIndicatorTintColor = UIColor(.currentPageControl)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        
        pageControl.setIndicatorImage(.pageRectangle, forPage: pageControl.currentPage)
        
        return pageControl
    }()
    
    func updatePageControlUI(currentPageIndex: Int) {
        
        (0..<pageControl.numberOfPages).forEach { (index) in
            let activePageIconImage = UIImage(resource: .pageRectangle)
            let otherPageIconImage = UIImage(resource: .dot)
            let pageIcon = index == currentPageIndex ? activePageIconImage : otherPageIconImage
            pageControl.setIndicatorImage(pageIcon, forPage: index)
        }
        
    }
    
    private func initialize(){
        view.backgroundColor = .BG
        
        //CollectionView
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.contentInsetAdjustmentBehavior = .never

        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.register(SlidesCollectionViewCell.self, forCellWithReuseIdentifier: "slidesCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 118))
        }
    }
    
    @objc func goToSingIn(){
        let signInVC = SignInViewController()
        navigationController?.show(signInVC, sender: self)
    }
    
    
}

//MARK: - Private extensions
private extension OnBoardingViewController{
    func dynamicValue(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseScreenSize = CGSize(width: 375, height: 812)
        let scaleFactor = min(screenSize.width, screenSize.height) / min(baseScreenSize.width, baseScreenSize.height)
        
        return size * scaleFactor
    }
}
