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
    
    let str = ConstGroup.TMP_STR
    
    var tmpflag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.webView.navigationDelegate = self
//        self.headerView.backgroundColor = .clear
        setup()
        tmp()
    }
    
    func setup() {
        self.headerStickyView.backgroundColor = .clear
        self.stickyBorderView.backgroundColor = .clear
        self.stickyBackButton.setImage(UIImage(named:"14BackWhite"), for: .normal)
        
        self.webView.scrollView.isScrollEnabled = false
        self.webView.navigationDelegate = self
        self.webView.loadHTMLString(str, baseURL: nil)
    }
    
    func tmp() {
        guard tmpflag else { return }
        self.headerImageView.image = UIImage(named: "dee1")
        self.titleLabel.text = "가게 배달지역 관리방식 개편 프로젝트"
        self.logoLabel.text = "디독"
        self.logoImageView.image = UIImage(named: "d_logo")
        self.dateLabel.text = "03/08/2021"
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

