//
//  MailDetailViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/02.
//

import Foundation
import UIKit
import WebKit

enum detailSection: Int, CaseIterable {
    case header
    case webview
}

class MailDetailViewController: UIViewController {
    //헤더뷰
    @IBOutlet weak var headerLayoutView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //스크롤 스티키 헤더뷰
    @IBOutlet weak var headerStickyView: UIView!
    @IBOutlet weak var stickyBackButton: UIButton!
    @IBOutlet weak var stickyBookMarkButton: UIButton!
    @IBOutlet weak var stickyBorderView: UIView!
    //웹뷰
    @IBOutlet weak var webView: WKWebView!
    
    //스크롤뷰
    @IBOutlet weak var scrollView: UIScrollView!
    
    var letterId: Int?
    var data: DI_Mail?
    let str = ConstGroup.TMP_STR
    
//    var tmpflag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.webView.navigationDelegate = self
//        self.headerView.backgroundColor = .clear
        setup()
    }
    
    func show() {
        request()
    }
    
    func setup() {
        self.headerStickyView.backgroundColor = .clear
        self.stickyBorderView.backgroundColor = .clear
        self.stickyBackButton.setImage(UIImage(named:"14BackWhite"), for: .normal)
    }
    
    func request() {
        guard let letterId = letterId else { return }
        DataRequest.getLetterHtml(id: letterId) {[weak self] data in
            guard let `self` = self else { return }
            self.webView.scrollView.isScrollEnabled = false
            self.webView.navigationDelegate = self
            self.webView.loadHTMLString(data, baseURL: nil)
        } failure: { _ in
            print("html 못가져옴")
        }
        DataRequest.getLetterDetail(id: letterId) { [weak self] data in
            guard let `self` = self else { return }
            self.data = data
            self.bind()
        } failure: { _ in
            print("메일 못가져옴")
        }
    }
    
    func bind() {
        guard let data = self.data else { return }
        self.headerImageView.image = UIImage(named: "dee1")
        self.titleLabel.text = data.title
        self.logoLabel.text = data.platformName
        self.logoImageView.load(urlStr: data.platformImageUrl)
        self.dateLabel.text = data.createdAt
    }
    
    @IBAction func onBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBookMarkButton(_ sender: UIButton) {
        
    }
}

extension MailDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        let height = self.webView.scrollView.contentSize.height
        self.webView.heightConstraint = height }
    }
}

extension MailDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let flagHeight = self.headerLayoutView.heightDefaultConstraint - self.headerStickyView.heightDefaultConstraint
        if scrollView.contentOffset.y < flagHeight {
            self.headerStickyView.backgroundColor = .clear
            self.stickyBorderView.backgroundColor = .clear
            self.stickyBackButton.setImage(UIImage(named:"14BackWhite"), for: .normal)
        }
        else {
            self.headerStickyView.backgroundColor = .white
            self.stickyBorderView.backgroundColor = UIColor(rgb: 0xbdbdbd)
            self.stickyBackButton.setImage(UIImage(named:"14BackPickygray"), for: .normal)
        }
    }
}

