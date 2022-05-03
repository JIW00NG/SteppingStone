//
//  ContentView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Goala.mainGoal, ascending: true)],
        animation: .default)
    private var goals: FetchedResults<Goala>

    var body: some View {
        NavigationView {
            List {
                ForEach(goals) { goal in
                    NavigationLink {
                        Text("Goal is \(goal.mainGoal!)")
                    } label: {
                            Text(goal.mainGoal!)
                    }
                }
                .onDelete(perform: deleteGoals)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addGoal) {
                        Label("Add Goal", systemImage: "plus")
                    }
                }
            }
            Text("Select an goal")
        }
    }

    private func addGoal() {
        withAnimation {
            let newGoal = Goala(context: viewContext)
            newGoal.mainGoal = "집에가기"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteGoals(offsets: IndexSet) {
        withAnimation {
            offsets.map { goals[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
