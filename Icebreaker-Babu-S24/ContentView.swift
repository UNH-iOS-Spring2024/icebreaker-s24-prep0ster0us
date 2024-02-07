import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    // initalize firestore database
    let db = Firestore.firestore()
    
    @State private var fname: String = ""
    @State private var lname: String = ""
    @State private var pname: String = ""
    @State private var answer: String = ""
    @State private var question: String = ""
    
    @State var questions = [QuestionModel]()
    
    var body: some View {
        VStack {
            Text("Icebreaker")
                .font(.system(size: 40))
                .bold()
            Text("Built with SwiftUI")
            TextField("First Name", text: $fname)
            TextField("Last Name", text: $lname)
            TextField("Preferred  Name", text: $pname)
            Button(action: {setRandomQuestion()}) {
                Text("Get a random question")
                    .font(.system(size: 28))
            }
            Text(question)
            TextField("Answer", text: $answer)
            Button(action: {writeStudentToDatabase()}) {
                Text("Submit")
                    .font(.system(size: 28))
            }
        }
        .autocorrectionDisabled()
        .multilineTextAlignment(.center)
        .font(.system(size: 24))
        .padding()
        .onAppear() {
            getQuestionFromFirebase()
        }
    }
    
    func setRandomQuestion() {
        print("set random question was pressed")
        print("First name = \(fname)")
        
        var newQuestion = questions.randomElement()?.text
        self.question = question
        // same as
        // "if(self.question != nil) self.question = question!"
    }
    
    func getQuestionFromFirebase() {
        db.collection("questions")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {      // if error not nil, print error
                    print("Error getting documents: \(err)")
                } else {                // otherwise, get data from firestore
                    for doc in querySnapshot!.documents {
                        print("Question fetched: \(doc.documentID)")
                    }
                }
            }
    }
    
    func writeStudentToDatabase() {
        print("submit was pressed")
        print("First name = \(fname)")
        print("Last name = \(lname)")
        print("Preferred name = \(pname)")
        print("Answer = \(answer)")
    }
}

#Preview {
    ContentView()
}
