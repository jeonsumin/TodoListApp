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
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.loadTasks()
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
    func saveTasks(){
        let data = self.tasks.map {
            [
                "title":$0.title,
                "done":$0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        
        // userDefaults에 key 저장 set
        userDefaults.set(data, forKey: "tasks")
    }
    
    func loadTasks(){
        
        let userDefaults = UserDefaults.standard
        
        //userDefaults에 저장된 데이터 불러오기 ojbect
        guard let data = userDefaults.object(forKey: "tasks") as? [[String:Any]] else { return }
        
        //userDefaults에 저장된 데이터를 task 배열에 저장
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
    
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
        if task.done {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell 
    }
}

//MARK: TableView Delegate
extension ViewController:UITableViewDelegate {
    
    //어떤 cell을 선택했는지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
