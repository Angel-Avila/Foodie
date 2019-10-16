//
//  ViewController.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

class ViewController<V: View>: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var controllerView: V!
    
    private var showsNavBar: Bool!
    private var didAddView = false
    private var savedTitle = ""
    private var belowStatusBar: Bool!
    
    init(showsNavBar: Bool = false, title: String = "", belowStatusBar: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        self.showsNavBar = showsNavBar
        savedTitle = title
        self.title = title
        self.belowStatusBar = belowStatusBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if !showsNavBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            view.addSubview(controllerView)
            
            let statusBarHeight = belowStatusBar ?  UIApplication.shared.statusBarFrame.size.height : 0
            
            controllerView.pin.all()
            controllerView.pin.top(statusBarHeight)
            controllerView.setupUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = savedTitle
        
        if showsNavBar {
            
            if !didAddView {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                
                view.addSubview(controllerView)
                controllerView.pin.top(view.pin.safeArea + topBarHeight)
                    .bottom()
                    .horizontally()
                
                controllerView.setupUI()
                didAddView = true
            }
        }
        
        if !showsNavBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    private var topBarHeight: CGFloat {
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + navBarHeight
        return topBarHeight
    }
}
