//
//  OnBoardingViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 22.10.2024.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
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
    
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.pageIndicatorTintColor = UIColor(.pageControl)
        pageControl.currentPageIndicatorTintColor = UIColor(.currentPageControl)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        
        pageControl.setCurrentPageIndicatorImage(.pageRectangle, forPage: pageControl.currentPage)
        
        return pageControl
    }()
    
    private func initialize(){
        view.backgroundColor = .BG
        
        //CollectionView
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.register(SlidesCollectionViewCell.self, forCellWithReuseIdentifier: "slidesCell")
        
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    @objc func goToSingIn(){
        let signInVC = SignInViewController()
        navigationController?.show(signInVC, sender: self)
    }
    
    
}