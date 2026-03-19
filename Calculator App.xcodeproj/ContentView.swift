import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var currentNumber: Double = 0
    @State private var previousNumber: Double = 0
    @State private var operation: String = ""
    @State private var isNewNumber = true

    let buttons: [[String]] = [
        ["C", "+/-", "%", "÷"],
        ["7","8","9","×"],
        ["4","5","6","−"],
        ["1","2","3","+"],
        ["0",".","="]
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 12) {
                Spacer()

                // Display
                HStack {
                    Spacer()
                    Text(display)
                        .font(.system(size: 70, weight: .light))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding()

                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                buttonTapped(button)
                            }) {
                                Text(button)
                                    .font(.system(size: 28, weight: .medium))
                                    .frame(
                                        width: button == "0" ? 160 : 70,
                                        height: 70
                                    )
                                    .background(getColor(button))
                                    .foregroundColor(.white)
                                    .cornerRadius(35)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }

    // MARK: - Logic
    func buttonTapped(_ button: String) {
        switch button {

        case "0"..."9":
            if isNewNumber {
                display = button
                isNewNumber = false
            } else {
                display = display == "0" ? button : display + button
            }

        case ".":
            if !display.contains(".") {
                display += "."
            }

        case "C":
            display = "0"
            currentNumber = 0
            previousNumber = 0
            operation = ""
            isNewNumber = true

        case "+/-":
            if let value = Double(display) {
                display = formatResult(-value)
            }

        case "%":
            if let value = Double(display) {
                display = formatResult(value / 100)
            }

        case "+", "−", "×", "÷":
            previousNumber = Double(display) ?? 0
            operation = button
            isNewNumber = true

        case "=":
            currentNumber = Double(display) ?? 0

            var result: Double = 0

            switch operation {
            case "+": result = previousNumber + currentNumber
            case "−": result = previousNumber - currentNumber
            case "×": result = previousNumber * currentNumber
            case "÷":
                if currentNumber == 0 {
                    display = "Error"
                    return
                }
                result = previousNumber / currentNumber
            default: return
            }

            display = formatResult(result)
            isNewNumber = true

        default:
            break
        }
    }

    // MARK: - Format Numbers
    func formatResult(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(value))"
        } else {
            return "\(value)"
        }
    }

    // MARK: - Colors
    func getColor(_ button: String) -> Color {
        if ["+","−","×","÷","="].contains(button) {
            return .orange
        } else if ["C","+/-","%"].contains(button) {
            return Color.gray
        } else {
            return Color(white: 0.2)
        }
    }
}

// Preview
#Preview {
    ContentView()
}
