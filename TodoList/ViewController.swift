//
//  ViewController.swift
//  TodoList
//
//  Created by Terry on 2021/12/29.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }
    
    //MARK: IBAction
    @IBAction func tapEditBtn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func tapAddBtn(_ sender: UIBarButtonItem) {
        
        //Alert
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
//            debugPrint("\(alert.textFields?[0].text)")
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(registerButton)
        alert.addAction(cancleButton)
        alert.addTextField { textField in
            textField.placeholder = "할 일을 입력해주세요"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: function
    
    
}
//MARK: TableView DataSource
extension ViewController:UITableViewDataSource {
    
    //각 세션에 표시할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    //특정 인덱스 Row의 Cell에 대한 정보를 넣어 Cell을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell 
    }
    
    
}
