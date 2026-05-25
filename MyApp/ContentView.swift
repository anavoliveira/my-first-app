import SwiftUI

struct ContentView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 24) {
            Text("Contador")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("\(count)")
                .font(.system(size: 80, weight: .thin, design: .rounded))
                .monospacedDigit()
                .animation(.spring(), value: count)

            HStack(spacing: 48) {
                Button {
                    count -= 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.red)
                }

                Button {
                    count += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.green)
                }
            }

            Button("Resetar") {
                count = 0
            }
            .buttonStyle(.bordered)
            .tint(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
