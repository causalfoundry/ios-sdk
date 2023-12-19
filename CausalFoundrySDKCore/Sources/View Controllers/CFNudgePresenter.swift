//
//  CFNudgePresenter.swift
//
//
//  Created by Causal Foundry on 07.12.23.
//

import UIKit

public final class CFNudgePresenter {
    
    @available(iOS 13.0, *)
    public static func present(in uiViewController: UIViewController) {
        let objects = MMKVHelper.shared.readNudges().filter { !$0.isExpired }
        
        guard !objects.isEmpty else { return }
        
        let vc = CFNudgeViewController(objects: objects)
        uiViewController.present(vc, animated: true)
        
        MMKVHelper.shared.writeNudges(objects: [])
    }
    
    public static func presentWithData(in uiViewController: UIViewController, objects : [BackendNudgeMainObject]) {
        if #available(iOS 13.0, *) {
            guard !objects.isEmpty else { return }
            if uiViewController.presentedViewController != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + NotificationConstants.shared.IN_APP_MESSAGE_INITIAL_DELAY) {
                    let vc = CFNudgeViewController(objects: objects)
                    uiViewController.present(vc, animated: true)
                    MMKVHelper.shared.writeNudges(objects: [])
                }
            }else {
                let vc = CFNudgeViewController(objects: objects)
                uiViewController.present(vc, animated: true)
                MMKVHelper.shared.writeNudges(objects: [])
            }
        }
    }
}

@available(iOS 13.0, *)
fileprivate final class CFNudgeViewController: UITableViewController {
    
    private enum Section: Int {
        case one
    }
        
    private lazy var dataSource = makeDataSource()
    private var objects: [BackendNudgeMainObject]
    
    init(objects: [BackendNudgeMainObject]) {
        self.objects = objects
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        modalPresentationStyle = .overFullScreen
        view.backgroundColor = .clear
        
        tableView.isOpaque = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(CFNudgeCell.self, forCellReuseIdentifier: "CFNudgeCell")
        tableView.dataSource = dataSource
        
        updateDatasource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = dataSource.itemIdentifier(for: indexPath) else { return }
        CFNotificationController.shared.trackAndOpen(object: object)
        if let cta = object.nd.cta, cta == "redirect" || cta == "add_to_cart",
           let itemType = object.nd.message?.tmplCFG?.itemPairCFG?.itemType, !itemType.isEmpty,
           let itemID = object.extra?.itemPair?.ids?.first, !itemID.isEmpty
        {
            removeAllObjects()
        }else{
            remove(object: object)
        }
        updateDatasource()
    }
    
    @available(iOS 13.0, *)
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, BackendNudgeMainObject> {
        UITableViewDiffableDataSource(tableView: tableView, cellProvider: {  tableView, indexPath, object in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CFNudgeCell", for: indexPath) as? CFNudgeCell
            cell?.object = object
            cell?.nudgeView?.closeAction = { [weak self] in
                if (self?.objects.firstIndex(of: object)) != nil {
                    self?.remove(object: object)
                    self?.updateDatasource()
                    CFNotificationController.shared.track(nudgeRef: object.ref, response: .discard)
                }
            }
            return cell
        })
    }
    
    private func updateDatasource() {
    
            guard !objects.isEmpty else {
                dismiss(animated: true)
                return
            }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BackendNudgeMainObject>()
            snapshot.appendSections([Section.one])
            snapshot.appendItems(objects, toSection: .one)
            dataSource.apply(snapshot, animatingDifferences: true)
            
            objects.forEach { object in
                CFNotificationController.shared.track(nudgeRef: object.ref, response: .shown)
            }
    }
    
    private func remove(object: BackendNudgeMainObject) {
        guard let index = objects.firstIndex(of: object) else { return }
        objects.remove(at: index)
    }
    private func removeAllObjects() {
        objects.removeAll()
    }
}

@available(iOS 13.0, *)
fileprivate final class CFNudgeCell: UITableViewCell {
    
    var nudgeView: CFNudgeView?
    
    var object: BackendNudgeMainObject? {
        didSet {
            nudgeView?.removeFromSuperview()
            guard let object = object else { return }
            nudgeView = CFNudgeView(object: object)
            nudgeView!.layer.masksToBounds = true
            nudgeView!.layer.cornerRadius = 8
            nudgeView!.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(nudgeView!)
            let inset: CGFloat = 6.0
            NSLayoutConstraint.activate([
                nudgeView!.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: inset),
                nudgeView!.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
                nudgeView!.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: inset),
                nudgeView!.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
            ])
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .clear
    }
}

fileprivate final class CFNudgeView: UIView {
    
    var closeAction: (() -> Void)?
    
    @available(iOS 13.0, *)
    init(object: BackendNudgeMainObject) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        let titleView = UILabel(frame: .zero)
        titleView.text = object.nd.message?.title ?? ""
        titleView.font = UIFont.preferredFont(forTextStyle: .headline)
        titleView.numberOfLines = 0
        titleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleView)
        
        let bodyView = UILabel(frame: .zero)
        bodyView.text = NudgeUtils.getBodyTextBasedOnTemplate(nudgeObject: object)
        bodyView.font = UIFont.preferredFont(forTextStyle: .body)
        bodyView.numberOfLines = 0
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bodyView)
        
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset),
            button.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            
            titleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleView.trailingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor, constant: -inset),
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset),
            titleView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            
            bodyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            bodyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            bodyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: inset),
            bodyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonAction() {
        closeAction?()
    }
}

//#if DEBUG
//#Preview {
//    let debugObjects = try? BackendNudgeMainObject.debugObjects()
//    return CFNudgeView(object: debugObjects!.first!)
//}
//#endif
