//
//  DBHelper.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/05/04.
//

import Foundation
import SQLite3

class DBHelper: ObservableObject {
    static let shared = DBHelper()
    
    var db: OpaquePointer?
    let databaseName = "SteppingStoneDB.sqlite"
    
    init() {
        self.db = createDB()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    private func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        do {
            let dbPath: String = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false).appendingPathComponent(databaseName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfully created DB. Path: \(dbPath)")
                return db
            }
        } catch {
            print("Error while creating Database -\(error.localizedDescription)")
        }
        
        
        createSubGoalTable()
        createGoalTable()
        
        return nil
    }
    
    func createGoalTable(){
        let query = """
               CREATE TABLE IF NOT EXISTS goal(
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               main_goal String NOT NULL
               );
               """
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
                
            }
            else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\nsqlte3_step failure while creating table: \(errorMessage)")
            }
        }
        else {
            let errorMessage = String(cString: sqlite3_errmsg(self.db))
            print("\nsqlite3_prepare failure while creating table: \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
    }
    
    func createSubGoalTable() {
        let query = """
               CREATE TABLE IF NOT EXISTS sub_goal(
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               main_goal_id INTEGER,
               sub_goal String,
               degree INTERGER,
               max_degree INTERGER,
               FOREIGN KEY(main_goal_id) REFERENCES goal(id)
               );
               """
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
                
            }
            else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\nsqlte3_step failure while creating table: \(errorMessage)")
            }
        }
        else {
            let errorMessage = String(cString: sqlite3_errmsg(self.db))
            print("\nsqlite3_prepare failure while creating table: \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertGoal(mainGoal: String) {
        let insertQuery = "insert into goal (id, main_goal) values (?, ?);"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 2, mainGoal, -1, nil)
            
        }
        else {
            print("sqlite binding failure")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func insertSubGoal(mainGoalId: Int, subGoal: String, maxDegree: Int) {
        let insertQuery = "insert into sub_goal (id, main_goal_id, sub_goal, degree, max_degree) values (?, ?, ?, ?, ?);"
        var statement: OpaquePointer? = nil
        
        print(insertQuery)
        
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 2, Int32(mainGoalId))
            sqlite3_bind_text(statement, 3, subGoal, -1, nil)
            sqlite3_bind_int(statement, 4, 0)
            sqlite3_bind_int(statement, 5, Int32(maxDegree))
        }
        else {
            print("sqlite binding failure")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func readGoalDataAll() -> [Goal] {
        let query: String = "select * from goal;"
        var statement: OpaquePointer? = nil
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        // Nil을 인식하지 못하는 것으로..
        var result: [Goal] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let mainGoal = String(cString: sqlite3_column_text(statement, 1))
            
            result.append(Goal(id: Int(id), mainGoal: mainGoal, subGoals: readSubGoalData(mainGoalId: Int(id))))
        }
        sqlite3_finalize(statement)
        
        return result
    }
    
    func readGoalData(id: Int) -> Goal? {
        let query: String = "select * from goal where id = \(id);"
        var statement: OpaquePointer? = nil
        
        var result: Goal?
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return nil
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let mainGoal = String(cString: sqlite3_column_text(statement, 1))
            
            result = Goal(id: Int(id), mainGoal: mainGoal, subGoals: readSubGoalData(mainGoalId: Int(id)))
        }
        sqlite3_finalize(statement)
        
        return result
    }
    
    func getGoalId(mainGoal: String) -> Int {
        let query: String = "select id from goal where main_goal == '\(mainGoal)';"
        var statement: OpaquePointer? = nil
        
        var result: Int32 = 0
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return Int(result)
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            result = sqlite3_column_int(statement, 0)
        }
        
        sqlite3_finalize(statement)
        
        return Int(result)
    }
    
    func getSubGoalId(subGoal: String) -> Int {
        let query: String = "select id from sub_goal where sub_goal == '\(subGoal)';"
        var statement: OpaquePointer? = nil
        
        var result: Int32 = 0
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return Int(result)
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            result = sqlite3_column_int(statement, 0)
        }
        
        sqlite3_finalize(statement)
        
        return Int(result)
    }
    
    func readSubGoalData(mainGoalId: Int) -> [SubGoal] {
        let query: String = "select * from sub_goal where main_goal_id == \(mainGoalId);"
        print("\(query)")
        var statement: OpaquePointer? = nil
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        // Nil을 인식하지 못하는 것으로..
        var result: [SubGoal] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            //                sqlite3_column_int(statement, 0)
            //                String(cString: sqlite3_column_text(statement, 1))
            let id = sqlite3_column_int(statement, 0)
            let mainGoalId = sqlite3_column_int(statement, 1)
            let subGoal = String(cString: sqlite3_column_text(statement, 2))
            let maxDegree = sqlite3_column_int(statement, 4)
            
            
            result.append(SubGoal(id: Int(id), mainGoalId: Int(mainGoalId), subGoal: subGoal, maxDegree: Int(maxDegree)))
        }
        sqlite3_finalize(statement)
        
        for r in result {
            print("\(r)")
        }
        
        return result
    }
    
    func readSubGoalData(id: Int, key: String) -> String {
        let query: String = "select \(key) from sub_goal where id == \(id);"
        var statement: OpaquePointer? = nil
        
        var result: String = ""
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            if key == "sub_goal" {
                result = String(cString: sqlite3_column_text(statement, 0))
            } else {
                result = String(sqlite3_column_int(statement, 0))
            }
        }
        
        sqlite3_finalize(statement)
        
        return result
    }
    
    func updateGoal(id: Int, mainGoal: String) {
        var statement: OpaquePointer?
        let queryString = "UPDATE goal SET main_goal = '\(mainGoal)' WHERE id == \(id)"
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("Update has been successfully done")
    }
    
    func updateSubGoal(id: Int, subGoal: String, degree: Int, maxDegree: Int) {
        var statement: OpaquePointer?
        let queryString = "UPDATE sub_goal SET sub_goal = '\(subGoal)', max_degree = \(maxDegree), degree = \(degree) WHERE id == \(id)"
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("Update has been successfully done")
    }
    
    func decreaseDegree(id: Int) {
        var statement: OpaquePointer?
        let queryString = "UPDATE sub_goal SET degree = degree - 1 WHERE id == \(id)"
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("Update has been successfully done")
    }
    
    func increaseDegree(id: Int) {
        var statement: OpaquePointer?
        let queryString = "UPDATE sub_goal SET degree = degree + 1 WHERE id == \(id)"
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("Update has been successfully done")
    }
    
    func deleteGoal(id: Int) {
        let queryString = "DELETE FROM goal WHERE id == \(id)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("delete has been successfully done")
    }
    
    func deleteSubGoal(id: Int) {
        let queryString = "DELETE FROM sub_goal WHERE id == \(id)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing update: \(errorMessage)")
            return
        }
        
        print("delete has been successfully done")
    }
}
