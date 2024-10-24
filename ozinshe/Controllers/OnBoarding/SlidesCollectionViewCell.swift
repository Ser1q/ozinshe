//
//  SlidesCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 22.10.2024.
//

import UIKit
import SnapKit

class SlidesCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initialize()
    }
    
    //configure func
    func configure(image: UIImage, titleText: String, descriptionText: String){
        imageView.image = image
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "titleColor")
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(.description)
        
        let attributedString = NSMutableAttributedString(string: "\(label)")

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 6 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label ***
        label.attributedText = attributedString
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(.title, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(.skipButton)
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Әрі қарай", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        button.layer.cornerRadius = 12
        button.backgroundColor = .primary
        
        return button
    }()
    
    private func initialize(){
        contentView.backgroundColor = UIColor(.BG)
        
        //imageView
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(contentView)
            make.height.equalTo(dynamicValue(for: 504))
        }
        
        //titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 419))
        }
        
        //desciptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 4
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(dynamicValue(for:-24))
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 32))
        }
        
        //skipButton
        contentView.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(70)
        }
        
        //nextButton
        contentView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(dynamicValue(for: -104))
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            
            make.height.equalTo(dynamicValue(for: 56))
            
        }
        
    }
}


//MARK: - Private extensions
private extension SlidesCollectionViewCell{
    func dynamicValue(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseScreenSize = CGSize(width: 375, height: 812)
        let scaleFactor = min(screenSize.width, screenSize.height) / min(baseScreenSize.width, baseScreenSize.height)
        
        return size * scaleFactor
    }
}

