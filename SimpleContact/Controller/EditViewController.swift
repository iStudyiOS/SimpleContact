//
//  EditViewController.swift
//  SimpleContact
//
//  Created by 김성진 on 2021/05/18.
//

import SnapKit
import UIKit

class EditViewController: UIViewController {
    private lazy var ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let favoriteLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "Memo"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 4
        return textView
    }()
    
    private var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 등록", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(addPhoto(_:)), for: .touchUpInside)
        return button
    }()
    
    private var yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("YES", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(clickYes(_:)), for: .touchUpInside)
        return button
    }()

    private var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("NO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(clickNo(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        title = "Edit"
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save(_:)))
    }
    
    @objc private func back(_ sender: Any) {
        // 현재 뷰를 메모리 상 제거 하고 이전 뷰로 돌아감 네비게이션 스택을 한번 pop처리
        navigationController?.popViewController(animated: true)
        print("back 클릭")
    }
    
    @objc private func save(_ sender: Any) {
        print("save 클릭")
        // TODO: UI 값 가져와서 Contact instance 생성하기
        
        guard let name = nameTextField.text else { return }
        guard let memo = memoTextView.text else { return }
        guard let phone = phoneTextField.text else { return }
        
        // favorite는 임시로 true로 설정함. create가 끝난 뒤 popViewController가 실행되도록 구현
        PersistenceManager.shared.createContact(name: name, memo: memo, phone: phone, favorite: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func addPhoto(_ sender: UIButton) {
        print("사진 등록")
    }
    
    @objc private func clickYes(_ sender: UIButton) {
        // 저장
        print("yes")
    }
    
    @objc private func clickNo(_ sender: UIButton) {
        print("No")
    }

    private func setupUI() {
        view.addSubview(ImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(favoriteLabel)
        view.addSubview(memoLabel)
        view.addSubview(addPhotoButton)
        view.addSubview(yesButton)
        view.addSubview(noButton)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(memoTextView)

        // Snapkit으로 Layout설정
        
        ImageView.snp.makeConstraints {
            $0.width.height.equalTo(120)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.left.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(-80)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalTo(nameLabel).offset(70)
            $0.trailing.equalTo(-80)
        }
        
        favoriteLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.centerX.equalTo(view)
        }
        
        memoLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalTo(view).offset(380)
            $0.centerX.equalTo(view)
        }
        
        addPhotoButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalTo(ImageView).offset(140)
            $0.leading.equalTo(50)
        }
        
        yesButton.snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(35)
            $0.top.equalTo(addPhotoButton).offset(100)
            $0.leading.equalTo(40)
        }
        
        noButton.snp.makeConstraints {
            $0.width.equalTo(yesButton)
            $0.height.equalTo(yesButton)
            $0.top.equalTo(yesButton)
            $0.trailing.equalTo(-40)
        }
        
        nameTextField.snp.makeConstraints {
            $0.width.equalTo(140)
            $0.height.equalTo(30)
            $0.top.equalTo(nameLabel).offset(35)
            $0.leading.equalTo(nameLabel)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.width.equalTo(140)
            $0.height.equalTo(30)
            $0.top.equalTo(phoneLabel).offset(35)
            $0.leading.equalTo(nameLabel)
        }
        
        memoTextView.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.top.equalTo(memoLabel).offset(40)
            $0.bottom.equalTo(view).offset(-30)
            $0.centerX.equalTo(view)
        }
    }
}

// SwiftUI코드로 레이아웃 프리뷰 확인

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    // makeUI
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        EditViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
        }
    }
}

#endif
