import SwiftUI

struct ContentView: View {
    @State private var invoices: [Invoice] = [Invoice.sample]
    @State private var showNewInvoice = false
    @State private var animateBackground = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Animated background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.97, green: 0.95, blue: 0.93),
                        Color(red: 0.99, green: 0.98, blue: 0.96)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header card
                        VStack(spacing: 16) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Welcome")
                                        .font(.system(size: 28, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Text("Honolulu Appliance Repair Pro")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(Color.white.opacity(0.8))
                                }
                                Spacer()
                                Image(systemName: "wrench.and.screwdriver.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            Divider()
                                .opacity(0.3)
                            
                            HStack(spacing: 20) {
                                VStack(spacing: 4) {
                                    Text(String(invoices.count))
                                        .font(.system(size: 24, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Text("Total Invoices")
                                        .font(.system(size: 12, weight: .regular, design: .default))
                                        .foregroundColor(Color.white.opacity(0.8))
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(height: 40)
                                
                                VStack(spacing: 4) {
                                    Text(String(format: "$%.2f", invoices.reduce(0) { $0 + $1.total }))
                                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                    Text("Total Revenue")
                                        .font(.system(size: 12, weight: .regular, design: .default))
                                        .foregroundColor(Color.white.opacity(0.8))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(20)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.45, blue: 0.0),
                                    Color(red: 0.95, green: 0.35, blue: 0.0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(20)
                        .shadow(color: Color(red: 1.0, green: 0.45, blue: 0.0).opacity(0.3), radius: 15, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        
                        // Recent invoices
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Recent Invoices")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            if invoices.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "doc.badge.ellipsis")
                                        .font(.system(size: 48))
                                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                                    Text("No invoices yet")
                                        .font(.system(size: 16, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(40)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(invoices, id: \.id) { invoice in
                                        NavigationLink(destination: InvoiceDetailView(invoice: invoice)) {
                                            InvoiceRowView(invoice: invoice)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.vertical, 24)
                }
            }
            .navigationBarItems(
                trailing: Button(action: { showNewInvoice = true }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                        Text("New")
                    }
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.0))
                }
            )
            .sheet(isPresented: $showNewInvoice) {
                Text("New Invoice Form Coming Soon")
            }
        }
    }
}

struct InvoiceRowView: View {
    let invoice: Invoice
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(invoice.clientName)
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    Spacer()
                    HStack(spacing: 6) {
                        Circle()
                            .fill(statusColor(invoice.status))
                            .frame(width: 8, height: 8)
                        Text(invoice.status.uppercased())
                            .font(.system(size: 11, weight: .semibold, design: .default))
                            .foregroundColor(statusColor(invoice.status))
                    }
                }
                
                Text("Invoice #\(String(format: "%05d", invoice.id))")
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                
                HStack {
                    Text(invoice.dateCreated.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 11, weight: .regular, design: .default))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    Spacer()
                    Text(String(format: "$%.2f", invoice.total))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.0))
                }
            }
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
    
    private func statusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "paid":
            return Color(red: 0.2, green: 0.8, blue: 0.3)
        case "pending":
            return Color(red: 1.0, green: 0.65, blue: 0.0)
        case "overdue":
            return Color(red: 1.0, green: 0.2, blue: 0.2)
        default:
            return Color(red: 0.5, green: 0.5, blue: 0.5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
