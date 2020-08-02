//
//  TreeViewController.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import UIKit

let NODE_VIEW_WIDTH = 300
let NODE_VIEW_HEIGHT = 70
let NODE_VERTICAL_SPACING = 20
let NODE_HORIZONTAL_SPACING = 40
var NODE_Y_ORIGIN = 20

enum Package: String {
    case G = "Gold"
    case B = "Bronze"
    case P = "Platinum"
}
enum RelationType: String {
    case Left
    case Right
}

class Node {
    let value: Customer //let's have value refer to childName
    var leftChild: Node?
    var rightChild: Node?

    init(value: Customer, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

class TreeViewController: UIViewController {
    
    //MARK: Properties
    var arrCustomers: [Customer?] = []
    var xOrigin = 20
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width + 200, height: self.view.frame.height + 1000)
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = self.view.bounds
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = contentViewSize
        scroll.contentInsetAdjustmentBehavior = .never
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //edgesForExtendedLayout = []
        navigationItem.hidesBackButton = true
        createBinaryTreeRecursively()
        
        //Setup layout
        setUpLayout()
    }
    
    
    //MARK: Custome methods
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func createBinaryTreeRecursively() {
        //
        let custOlimjon = Customer(childName: "OLIMJON ORZEIV", childId: 105475, parentId: 105474, package: "G", relationType: "Right", masterNode: 0)
        let custMarites = Customer(childName: "MARITES (ILAGAN 03, PRECIOUS RAMA UL) TENORIO", childId: 124940, parentId: 105474, package: "G", relationType: "Left", masterNode: 0)
        let custRama03 = Customer(childName: "03PRECIOUS RAMA ILAGAN 03", childId: 105474, parentId: 91615, package: "P", relationType: "Right", masterNode: 0)
        let custMarife = Customer(childName: "MARIFE ARAGAY",childId: 104194, parentId: 92718, package: "G", relationType: "Left", masterNode: 0)
        let custKleo = Customer(childName: "KLEO MARGOT ALCARAZ",childId: 92718, parentId: 92094, package: "G", relationType: "Left", masterNode: 0)
        let custCynthia = Customer(childName: "CYNTHIA PAHATI",childId: 92094, parentId: 92093, package: "G", relationType: "Left", masterNode: 0)
        let custRama02 = Customer(childName: "02PRECIOUS RAMA ILAGAN 02", childId: 92093, parentId: 91615, package: "P", relationType: "Left", masterNode: 0)
        let custRama01 = Customer(childName: "PRECIOUS RAMA ILAGAN 01",childId: 91615, parentId: 90749, package: "P", relationType: "Left", masterNode: 0)
        let custRolly = Customer(childName: "ROLLY ORESCA", childId: 90749, parentId: 0, package: "G", relationType: "", masterNode: 1)
                
        let olimjon = Node(value: custOlimjon, leftChild: nil, rightChild: nil)
        let marites = Node(value: custMarites, leftChild: nil, rightChild: nil)
        let rama03 = Node(value: custRama03, leftChild: nil, rightChild: nil)
        let marife = Node(value: custMarife, leftChild: nil, rightChild: nil)
        let kleo = Node(value: custKleo, leftChild: nil, rightChild: nil)
        let cynthia = Node(value: custCynthia, leftChild: nil, rightChild: nil)
        let rama02 = Node(value: custRama02, leftChild: nil, rightChild: nil)
        let rama01 = Node(value: custRama01, leftChild: nil, rightChild: nil)
        let rolly = Node(value: custRolly, leftChild: nil, rightChild: nil)
        
        rama03.leftChild = marites
        rama03.rightChild = olimjon
        
        kleo.leftChild = marife
        
        cynthia.leftChild = kleo
        
        rama02.leftChild = cynthia
        
        rama01.leftChild = rama02
        rama01.rightChild = rama03
        
        rolly.leftChild = rama01

        //Add Empty
        kleo.rightChild = getEmptyChild(forNode: kleo, relationType: .Right)
        cynthia.rightChild = getEmptyChild(forNode: cynthia, relationType: .Right)
        rama02.rightChild = getEmptyChild(forNode: rama02, relationType: .Right)
        rolly.rightChild = getEmptyChild(forNode: rolly, relationType: .Right)
        olimjon.leftChild = getEmptyChild(forNode: olimjon, relationType: .Left)
        olimjon.rightChild = getEmptyChild(forNode: olimjon, relationType: .Right)
        marites.leftChild = getEmptyChild(forNode: marites, relationType: .Left)
        marites.rightChild = getEmptyChild(forNode: marites, relationType: .Right)
        marife.leftChild = getEmptyChild(forNode: marife, relationType: .Left)
        marife.rightChild = getEmptyChild(forNode: marife, relationType: .Right)

        drawNode(node: rolly)
    }
    
                
    func getEmptyChild(forNode node: Node,relationType: RelationType) -> Node {
        let customer = Customer(childName: "Empty", childId: 0, parentId: node.value.childId, package: "", relationType: relationType.rawValue, masterNode: 0)
        let node = Node(value: customer, leftChild: nil, rightChild: nil)
        return node
    }
    
    func addNodeView(forCustomer customer: Customer) {
       let view = contentView
        
        NODE_Y_ORIGIN += NODE_VERTICAL_SPACING + NODE_VIEW_HEIGHT
        if customer.masterNode == 0 {
            if let parent = view.viewWithTag(Int(customer.parentId)) {
                xOrigin = Int(parent.frame.origin.x) + NODE_HORIZONTAL_SPACING
            }
        }
        print("Node y origin is: \(NODE_Y_ORIGIN)")
        let nodeView = NodeView(frame: CGRect(x: xOrigin, y: NODE_Y_ORIGIN, width: NODE_VIEW_WIDTH, height: NODE_VIEW_HEIGHT))
        nodeView.tag = Int(customer.childId)
        nodeView.lblName.text = customer.childName
        
        //If node is not a root node
        if customer.masterNode == 0 {
            nodeView.viewCircle.isHidden = false
            nodeView.lblRelationType.text = customer.relationType == "Left" ? "L" : "R"
        }
        
        //If node is not empty
        if customer.childId != 0 {
            nodeView.lblPackage.isHidden = false
            switch customer.package {
            case "B":
                nodeView.lblPackage.text = "(Bronze)"
                nodeView.lblPackage.textColor = .brown
            case "G":
                nodeView.lblPackage.text = "(Gold)"
                nodeView.lblPackage.textColor = .yellow
            case "P":
                nodeView.lblPackage.text = "(Platinum)"
                nodeView.lblPackage.textColor = .blue
            default:
                break
            }
        }
        
        view.addSubview(nodeView)
        
        //Horizontal connector
        if customer.masterNode == 0 {
            let horizontalConnector = UIView(frame: CGRect(x: xOrigin - 20, y: Int(nodeView.center.y), width: 20, height: 3))
            horizontalConnector.backgroundColor = .black
            view.addSubview(horizontalConnector)
            
            //Vertical connector
            if let parent = view.viewWithTag(Int(customer.parentId)) {
                let x = horizontalConnector.frame.origin.x
                let y = parent.frame.origin.y + parent.frame.size.height
                let height = horizontalConnector.frame.origin.y - y
                let width = 3
                
                let verticalConnector = UIView(frame: CGRect(x: x, y: y, width: CGFloat(width), height: height))
                verticalConnector.backgroundColor = .black
                view.addSubview(verticalConnector)
            }
        }
    }
    
    func drawNode(node: Node?) {
        node?.traversePreOrder(visit: { (cust) in
            self.addNodeView(forCustomer: cust)
        })
    }
}

extension Node {
//    func traverseInOrder(visit: (Customer)->()) {
//        if let leftChild = leftChild {
//            print("Left Child \(leftChild.value.childName) exists for \(value.childName)")
//            //Add left nodes and traverse recursively
//            visit(value)
//            leftChild.traverseInOrder(visit: visit)
//        }
//        else {
//            print("No left child exists for \(value.childName)")
//            visit(value)
//        }
//
//        //visit(value)
//        print("Visiting: \(value.childName)")
//
//        if let rightChild = rightChild {
//            //print("Right Child \(rightChild.value.childName) exists for \(value.childName)")
//            rightChild.traverseInOrder(visit: visit)
//        }
//        else {
//            //print("No right child exists for \(value.childName)")
//        }
//    }
    
    func traversePreOrder(visit: (Customer)->()) {
        visit(value)
        if let leftChild = leftChild {
            print("Left Child \(leftChild.value.childName) exists for \(value.childName)")
            //Add left nodes and traverse recursively
            leftChild.traversePreOrder(visit: visit)
        }
        else {
            print("No left child exists for \(value.childName)")
            //visit(nil)
        }
        
        //visit(value)
        print("Visiting: \(value.childName)")
        
        if let rightChild = rightChild {
            //print("Right Child \(rightChild.value.childName) exists for \(value.childName)")
            rightChild.traversePreOrder(visit: visit)
        }
        else {
            //print("No right child exists for \(value.childName)")
        }
    }
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}
