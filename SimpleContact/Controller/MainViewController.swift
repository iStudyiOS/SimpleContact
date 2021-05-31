//
//  ViewController.swift
//  SimpleContact
//
//  Created by 김진태 on 2021/05/18.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    // MARK: - Property
    
    private let headerView: UIView = UIView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        // searchBar의 불필요한 상하단 선 제거
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.placeholder = "Search name"
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton(type: .system) // type을 system으로 하여야 터치하였을 때 feedback이 생김
        button.setTitle("ALL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(allButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system) // type을 system으로 하여야 터치하였을 때 feedback이 생김
        button.setTitle("Favorite", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system) // type을 system으로 하여야 터치하였을 때 feedback이 생김
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var topButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allButton, favoriteButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let dummyData: [Person] = PersistenceManager.shared.read()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - Helper

    private func setupUI() {
        // 기본 뷰의 background color 설정
        view.backgroundColor = .systemBackground
        
        // headerView 설정
        view.addSubview(headerView)
        // headerView의 Subview searchBar 설정
        headerView.addSubview(searchBar)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        // headerView의 Subview topButtonStackView 설정
        headerView.addSubview(topButtonStackView)
        topButtonStackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalTo(searchBar).offset(8)
            $0.bottom.equalTo(headerView).offset(-16)
        }
        // headerView의 Subview addButton 설정
        headerView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(topButtonStackView)
            $0.trailing.equalTo(searchBar).offset(-8)
        }
        
        // Button들의 크기 설정
        allButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        favoriteButton.snp.makeConstraints {
            $0.width.height.equalTo(allButton)
        }
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(allButton)
        }
        
        // tableView의 autoLayout 설정
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
    }
    
    
    // MARK: - Selector
    @objc private func allButtonTapped(_ sender: UIButton) {
        print("all button이 터치되었습니다.")
    }
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        print("favorite button이 터치되었습니다.")
    }
    @objc private func addButtonTapped(_ sender: UIButton) {
        let editViewController = EditViewController()
        // EditViewController push
        self.navigationController?.pushViewController(editViewController, animated: true)
        print("add button이 터치되었습니다.")
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier, for: indexPath) as? MainViewTableViewCell else {
            let viewControllerName = String(describing: MainViewController.self)
            fatalError("\(viewControllerName)에서 \(MainViewTableViewCell.identifier)를 dequeue하는 데에 실패하였습니다.")
        }
        cell.nameText = dummyData[indexPath.row].name
        cell.phoneText = dummyData[indexPath.row].phone
        cell.memoText = dummyData[indexPath.row].memo
        cell.isFavorite = dummyData[indexPath.row].favorite
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.selectionStyle = .default
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.selectionStyle = .none
    }
  

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)번째 cell이 터치되었습니다")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // leadungSwipe는 왼쪽 스와이프
        
        let like = UIContextualAction(style: .normal, title: "like") { (UIContextualAction, UIView, success: @escaping(Bool) -> Void) in
            print("Like 클릭")
            success(true)
        }
        like.image = UIImage(systemName: "star")
        like.title = nil
        like.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [like])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            // trailingSwipe는 오른쪽 스와이프
            
            let edit = UIContextualAction(style: .normal, title: "Edit") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Edit 클릭")
                success(true)
            }
            edit.backgroundColor = .systemBlue
            
            
            let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Delete 클릭")
                success(true)
            }
            delete.backgroundColor = .systemRed
            
            //actions배열 인덱스 0이 오른쪽에 붙어서 나옴
            return UISwipeActionsConfiguration(actions:[delete, edit])
        }
}

