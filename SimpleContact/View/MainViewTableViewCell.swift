//
//  MainViewTableViewCell.swift
//  SimpleContact
//
//  Created by 김진태 on 2021/05/18.
//

import SnapKit
import UIKit

class MainViewTableViewCell: UITableViewCell {
    // MARK: - Property

    static let identifier = String(describing: MainViewTableViewCell.self)
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()

    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "phone"
        return label
    }()

    private let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "memo"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    private let starIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    var personImage: UIImage? {
        get {
            return personImageView.image
        }
        set {
            personImageView.image = newValue
        }
    }
    
    var nameText: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var phoneText: String? {
        get {
            return phoneLabel.text
        }
        set {
            phoneLabel.text = newValue
        }
    }
    
    var memoText: String? {
        get {
            return memoLabel.text
        }
        set {
            memoLabel.text = newValue
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            starIconView.tintColor = isFavorite ? .systemYellow : .lightGray
        }
    }
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper

    private func setupUI() {
        selectionStyle = .none
        
        let titleStackView = UIStackView(arrangedSubviews: [nameTitleLabel, phoneTitleLabel, memoTitleLabel])
        titleStackView.axis = .vertical
        titleStackView.spacing = 8
        contentView.addSubview(titleStackView)
        
        contentView.addSubview(personImageView)
        
        personImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleStackView)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(56)
        }
        
        personImageView.layer.cornerRadius = 56 / 2
        
        contentView.addSubview(titleStackView)
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(personImageView.snp.trailing).offset(24)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(nameTitleLabel)
            $0.leading.equalTo(titleStackView.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().offset(-12)
        }
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(phoneTitleLabel)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(memoLabel)
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(memoTitleLabel)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(starIconView)
        starIconView.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.leading.top.equalToSuperview().offset(8)
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
