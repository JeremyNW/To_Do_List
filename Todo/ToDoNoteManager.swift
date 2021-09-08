//
//  ToDoNoteManager.swift
//  Todo
//
//  Created by Jeremy Warren on 9/8/21.
//

import Foundation

class TodoNoteManager {
    var todoNotes: [TodoNote] = []
    
    var fileURL: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("notes")
        url.appendPathExtension("json")
        return url
    }
    
    init() {
        loadNotes()
    }
    
    // C
    func createTodo(title: String, subtitle: String) {
        // create a new note
        let note = TodoNote(title: title, subtitle: subtitle)
        
        // add it to the array
        todoNotes.append(note)
        
        // save the array
        saveNotes()
    }
    
    // D
    func deleteTodo(note: TodoNote) {
        // get the index
        guard let index = todoNotes.firstIndex(of: note) else { return }
        
        // remove note from array
        todoNotes.remove(at: index)
        
        // save the array
        saveNotes()
    }
    
    
    func saveNotes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todoNotes)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadNotes() {
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL)
            let todoNotes = try decoder.decode([TodoNote].self, from: data)
            self.todoNotes = todoNotes
        } catch {
            print(error)
        }
    }
}
