//
//  HelpViewController.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 25.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let fontSize = (UIScreen.main.currentMode!.size.width >= 750) ? K.fontSizeTextViewNormal-2 : K.fontSizeTextViewZoomed-2
    var textViews : [UITextView]!

    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func pageChanged(_ sender: UIPageControl) {
        UIView.animate(withDuration: 0.3, delay: 0,
                         options: [.curveEaseInOut], animations: {
                            self.scrollView.contentOffset = CGPoint(
                                x: self.scrollView.bounds.size.width *
                                    CGFloat(sender.currentPage), y: 0)
        },
                         completion: nil)
    }
    private func setPageControl() {
        pageControl.pageIndicatorTintColor = K.foregroundDarkerColor
        pageControl.currentPageIndicatorTintColor = K.foregroundLighterColor
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
    }
    private func addTextViews() {
        let width = scrollView.bounds.size.width
        let height = scrollView.bounds.size.height
        print(scrollView.bounds.size)
        let margin : CGFloat = 30
        for (i, text) in K.helpCrowdGameTexts.enumerated() {
            let frame = CGRect (x: margin+CGFloat(i)*width, y: margin, width: width-2*margin, height: height-2*margin)
            print("===text#\(i): frame=\(frame)")
            if i==1 {
                let viewNib = UINib(nibName: "help1", bundle: nil)
                let viewHelp1 = viewNib.instantiate(withOwner: scrollView, options: nil)[0] as? UIView
                if let viewHelp1 = viewHelp1 {
                    viewHelp1.frame = frame
                    scrollView.addSubview(viewHelp1)
                }
            } else {
                let textView = UITextView(frame: frame)
                textView.font = .systemFont(ofSize: fontSize)
                textView.textColor = K.grayColor
                textView.text = text
                textView.isEditable = false
                textView.isSelectable = false
            }
        }
    }
    private func setScrollViewSize() {
        let width = scrollView.bounds.size.width
        let height = scrollView.bounds.size.height
        scrollView.contentSize = CGSize(width: width * CGFloat(K.helpCrowdGameTexts.count), height: height)
        print(scrollView.contentSize)
    }
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = K.cornerRadius
        addTaps(for: self, forSingle: #selector(singleTap))
        setScrollViewSize()
        addTextViews()
        setPageControl()
    }
}

extension HelpVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let page = Int((scrollView.contentOffset.x + width / 2)
            / width)
        pageControl.currentPage = page
    }
}
