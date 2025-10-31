//
//  CFActionPresenter.swift
//
//
//  Created by Causal Foundry on 07.12.23.
//

import UIKit

public final class CFActionPresenter {
    
    @available(iOS 13.0, *)
    public static func present(in uiViewController: UIViewController) {
        let objects = MMKVHelper.shared.readActions().filter { nudge in
            !(nudge.payload?.isExpired ?? false) && (nudge.error?.isEmpty ?? true)
        }
        
        guard !objects.isEmpty else { return }
        
        let vc = CFActionViewController(objects: objects)
        uiViewController.present(vc, animated: true)
        
        MMKVHelper.shared.writeActions(objects: [])
    }
    
    public static func presentWithData(in uiViewController: UIViewController, objects : [NudgeResponseItem]) {
        if #available(iOS 13.0, *) {
            guard !objects.isEmpty else { return }
            if uiViewController.presentedViewController != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + NotificationConstants.shared.IN_APP_MESSAGE_INITIAL_DELAY) {
                    let vc = CFActionViewController(objects: objects)
                    uiViewController.present(vc, animated: true)
                    MMKVHelper.shared.writeActions(objects: [])
                }
            }else {
                let vc = CFActionViewController(objects: objects)
                uiViewController.present(vc, animated: true)
                MMKVHelper.shared.writeActions(objects: [])
            }
        }
    }
}

@available(iOS 13.0, *)
fileprivate final class CFActionViewController: UITableViewController {
    
    private enum Section: Int {
        case one
    }
        
    private lazy var dataSource = makeDataSource()
    private var objects: [NudgeResponseItem]
    
    init(objects: [NudgeResponseItem]) {
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
        tableView.register(CFActionCell.self, forCellReuseIdentifier: "CFActionCell")
        tableView.dataSource = dataSource
        
        updateDatasource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = dataSource.itemIdentifier(for: indexPath) else { return }
        CFNotificationController.shared.trackAndOpen(object: object.payload!)
        if let cta = object.payload?.attr?["cta_type"], cta == "redirect" || cta == "add_to_cart",
           let itemID = object.payload?.attr?["cta_id"], !itemID.isEmpty
        {
            removeAllObjects()
        }else{
            remove(object: object)
        }
        updateDatasource()
    }
    
    @available(iOS 13.0, *)
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, NudgeResponseItem> {
        UITableViewDiffableDataSource(tableView: tableView, cellProvider: {  tableView, indexPath, object in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CFActionCell", for: indexPath) as? CFActionCell
            cell?.object = object
            cell?.actionView?.closeAction = { [weak self] in
                if (self?.objects.firstIndex(of: object)) != nil {
                    self?.remove(object: object)
                    self?.updateDatasource()
                    CFNotificationController.shared.track(payload: object.payload, response: ActionRepsonse.Discard, details: "")
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
            var snapshot = NSDiffableDataSourceSnapshot<Section, NudgeResponseItem>()
            snapshot.appendSections([Section.one])
            snapshot.appendItems(objects, toSection: .one)
            dataSource.apply(snapshot, animatingDifferences: true)
            
            objects.forEach { object in
                CFNotificationController.shared.track(payload: object.payload, response: ActionRepsonse.Shown, details: "")
            }
    }
    
    private func remove(object: NudgeResponseItem) {
        guard let index = objects.firstIndex(of: object) else { return }
        objects.remove(at: index)
    }
    private func removeAllObjects() {
        objects.removeAll()
    }
}

@available(iOS 13.0, *)
fileprivate final class CFActionCell: UITableViewCell {
    
    var actionView: CFActionView?
    
    var object: NudgeResponseItem? {
        didSet {
            actionView?.removeFromSuperview()
            guard let object = object else { return }
            actionView = CFActionView(object: object)
            actionView!.layer.masksToBounds = true
            actionView!.layer.cornerRadius = 8
            actionView!.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(actionView!)
            let inset: CGFloat = 6.0
            NSLayoutConstraint.activate([
                actionView!.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: inset),
                actionView!.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
                actionView!.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: inset),
                actionView!.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
            ])
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .clear
    }
}

fileprivate final class CFActionView: UIView {
    
    var closeAction: (() -> Void)?
    
    @available(iOS 13.0, *)
    init(object: NudgeResponseItem) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        let titleView = UILabel(frame: .zero)
        titleView.text = object.payload?.content?["title"]
        titleView.font = UIFont.preferredFont(forTextStyle: .headline)
        titleView.numberOfLines = 0
        titleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleView)
        
        let bodyView = UILabel(frame: .zero)
        bodyView.attributedText = (object.payload?.content?["body"] ?? "").htmlAttributedString().with(font:UIFont.preferredFont(forTextStyle: .body))
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
//    let debugObjects = try? BackendActionMainObject.debugObjects()
//    return CFActionView(object: debugObjects!.first!)
//}
//#endif
