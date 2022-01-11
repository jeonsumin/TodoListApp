//
//  ViewController.swift
//  TodoList
//
//  Created by Terry on 2021/12/29.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editBtn: UIBarButtonItem!
    
    var doneButton:UIBarButtonItem?
    
    var tasks = [Task]() {
        //tasks 배열이 set된 후 saveTask()함수 호출
        didSet {
            self.saveTasks()
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneBtn))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.loadTasks()
    }
    
    //MARK: - IBAction
    @IBAction func tapEditBtn(_ sender: UIBarButtonItem) {
        //데이터가 없을 경우 편집모드로 들어가지 않도록 gaurd
        guard !self.tasks.isEmpty else { return }
        
        // editbutton을 눌렀을때 왼쪽 바 버튼은 doneButton 으로 변경
        self.navigationItem.leftBarButtonItem = self.doneButton
        
        // tableview 는 editing으로 설정
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func tapAddBtn(_ sender: UIBarButtonItem) {
        
        //AlertController 생성한다.
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        //AlertController에서 사용될 액션을 설정 한다.
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
//            debugPrint("\(alert.textFields?[0].text)")
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        //설정된 얼럿 액션을 AlertController에 추가
        alert.addAction(registerButton)
        alert.addAction(cancleButton)
        alert.addTextField { textField in
            textField.placeholder = "할 일을 입력해주세요"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - function
    func saveTasks(){
        let data = self.tasks.map {
            [
                "title":$0.title,
                "done":$0.done
            ]
        }
        //UserDefaults 선언
        let userDefaults = UserDefaults.standard
        
        // userDefaults에 key 저장 set
        userDefaults.set(data, forKey: "tasks")
    }
    
    func loadTasks(){
        //UserDefaults 선언
        let userDefaults = UserDefaults.standard
        
        //userDefaults에 저장된 데이터를 forKey에 value 불러오기 ojbect
        guard let data = userDefaults.object(forKey: "tasks") as? [[String:Any]] else { return }
        
        //userDefaults에 저장된 데이터를 다시 task 배열에 저장
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
    @objc func tapDoneBtn() {
        //왼쪽 바 버튼 아이템 done을 클릭시 editbutton으로 변경
        self.navigationItem.leftBarButtonItem = self.editBtn
        
        // 테이블뷰 editing 모드 빠져 나오기
        self.tableView.setEditing(false, animated: false)
    }
    
    
}

//MARK: - TableView DataSource
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
        
        //데이터의 done의 값이 변경될때마다 셀 악세서리 타입 변경
        if task.done {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell 
    }
}

//MARK: - TableView Delegate
extension ViewController:UITableViewDelegate {
    
    //어떤 cell을 선택했는지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    //편집모드에서의 기능 추가 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty{
            self.tapDoneBtn()
        }
    }
    
    // 셀 재정렬 메소드
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 셀 재정렬 메소드
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //앱이 재실행 되어도 재정렬한 체로 userDefaults에 저장될 수 있도록 tasks의 index 재설정
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
}
