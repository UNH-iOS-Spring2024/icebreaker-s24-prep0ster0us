import SwiftUI

struct ContentView: View {
    @State private var fname: String = ""
    @State private var lname: String = ""
    @State private var pname: String = ""
    @State private var answer: String = ""
    @State private var question: String = ""
    
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            Text("Icebreaker")
                .font(.system(size: 40))
                .bold()
            Text("Built with SwiftUI")
            TextField("First Name", text: $fname)
            TextField("Last Name", text: $lname)
            TextField("Preferred  Name", text: $pname)
            Button(action: {getRandomQuestion()}) {
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
    }
    
    func getRandomQuestion() {
        print("set random question was pressed")
        print("First name = \(fname)")
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
