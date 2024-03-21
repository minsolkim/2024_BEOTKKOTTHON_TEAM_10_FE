//
//  ViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/16.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, HomeHeaderCellDelegate, HomeFooterCellDelegate {
    //MARK: - UIComponent
    private lazy var mainIcon : UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "mainIcon"), style: .plain, target: self, action: nil)
        view.tintColor = .PrimaryColor
        return view
    }()
    //검색 버튼
    private lazy var searchBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        btn.tintColor = .gray
        return btn
    }()
    //알림 버튼
    private lazy var alertBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        btn.tintColor = .gray
        return btn
    }()
    //상세 페이지 테이블
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(HomeHeaderCell.self, forCellReuseIdentifier: "FirstCell")
        view.register(HomeMiddleCell.self, forCellReuseIdentifier: "SecondCell")
        view.register(HomeFooterCell.self, forCellReuseIdentifier: "ThirdCell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        view.allowsSelection = false
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .black
    }
}
//MARK: - setLayout
extension HomeViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = mainIcon
        self.navigationItem.rightBarButtonItems = [alertBtn, searchBtn]
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}
//MARK: - setTableView
extension HomeViewController {
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 370
        case 1:
            return 250
        case 2:
            return 350
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? HomeHeaderCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? HomeMiddleCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as? HomeFooterCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
    }
}
// MARK: - Actions
extension HomeViewController {
    func didTapAnnouncementButton() {
        let announcementVC = AnnoucementViewController(order: "마감순")
        navigationController?.pushViewController(announcementVC, animated: true)
    }
    func didTapNewAnnouncementButton() {
        let announcementVC = AnnoucementViewController(order: "최신순")
        navigationController?.pushViewController(announcementVC, animated: true)
    }
}
