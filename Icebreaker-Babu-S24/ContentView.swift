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
            Button(action: {
                if(answer != "") {
                    writeStudentToDatabase()
                }
                resetTextFields()
            }) {
                Text("Submit")
                    .font(.system(size: 36))
            }
            .padding(30)
            
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
        if(newQuestion != nil) {
            self.question = newQuestion!
        }
    }
    
    func getQuestionFromFirebase() {
        db.collection("questions")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {      // if error not nil, print error
                    print("Error getting documents: \(err)")
                } else {                // otherwise, get data from firestore
                    for doc in querySnapshot!.documents {
                        if let question = QuestionModel(id: doc.documentID, data: doc.data()) {
                            print("Question ID: \(question.id), Question text: \(question.text)")
                            // add to questions array
                            self.questions.append(question)
                        }
                    }
                }
            }
    }
    
    func writeStudentToDatabase() {
        print("submit was pressed")
        print("First name = \(fname)")
        print("Last name = \(lname)")
        print("Preferred name = \(pname)")
        print("Question =  \(question)")
        print("Answer = \(answer)")
        print("Class = iOS-Spring-2024")
        
        let data = [
            "first_name" : fname,
            "last_name"  : lname,
            "pref_name"  : pname,
            "question"   : question,
            "answer"     : answer,
            "class"      : "iOS-Spring-2024"
        ] as [String: Any]
        
        var ref: DocumentReference? = nil
        ref = db.collection("students")
            .addDocument(data: data) { err in
                if let err = err {
                    print("Error adding to database: \(err)")
                } else {
                    print("Document added!")
                }
            }
        
    }
    
    func resetTextFields() {
        fname = ""
        lname = ""
        pname = ""
        question = ""
        answer = ""
        
    }
}

#Preview {
    ContentView()
}
