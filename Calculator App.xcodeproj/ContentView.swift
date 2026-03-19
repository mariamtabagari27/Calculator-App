import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var currentNumber: Double = 0
    @State private var previousNumber: Double = 0
    @State private var operation: String = ""

    let buttons = [
        ["7","8","9","÷"],
        ["4","5","6","×"],
        ["1","2","3","−"],
        ["0","C","=","+"]
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()

                // MARK: - Display
                HStack {
                    Spacer()
                    Text(display)
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }

                // MARK: - Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 15) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                buttonTapped(button)
                            }) {
                                Text(button)
                                    .font(.system(size: 28, weight: .bold))
                                    .frame(width: 70, height: 70)
                                    .background(getColor(button))
                                    .foregroundColor(.white)
                                    .cornerRadius(35)
                            }
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding()
        }
    }

    // MARK: - Button Logic
    func buttonTapped(_ button: String) {
        switch button {

        case "0"..."9":
            if display == "0" {
                display = button
            } else {
                display += button
            }

        case "C":
            display = "0"
            currentNumber = 0
            previousNumber = 0
            operation = ""

        case "+", "−", "×", "÷":
            previousNumber = Double(display) ?? 0
            operation = button
            display = "0"

        case "=":
            currentNumber = Double(display) ?? 0

            switch operation {
            case "+":
                display = "\(previousNumber + currentNumber)"
            case "−":
                display = "\(previousNumber - currentNumber)"
            case "×":
                display = "\(previousNumber * currentNumber)"
            case "÷":
                display = currentNumber == 0 ? "Error" : "\(previousNumber / currentNumber)"
            default:
                break
            }

        default:
            break
        }
    }

    // MARK: - Button Colors
    func getColor(_ button: String) -> Color {
        if ["+","−","×","÷","="].contains(button) {
            return .orange
        } else if button == "C" {
            return .gray
        } else {
            return Color(white: 0.3)
        }
    }
}

// Preview
#Preview {
    ContentView()
}

