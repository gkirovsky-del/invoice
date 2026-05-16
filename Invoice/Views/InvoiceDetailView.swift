import SwiftUI

struct InvoiceDetailView: View {
    let invoice: Invoice
    @State private var showPDF = false
    @State private var animateIn = false
    @State private var scale: CGFloat = 0.95
    
    var body: some View {
        ZStack {
            // Background gradient
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
                    // 3D Card Container
                    VStack(spacing: 0) {
                        // Header with gradient
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("INVOICE")
                                        .font(.system(size: 28, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Text("#\(String(format: "%05d", invoice.id))")
                                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                        .foregroundColor(Color.white.opacity(0.8))
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Image(systemName: "wrench.and.screwdriver.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(20)
                            
                            // Status badge
                            HStack(spacing: 8) {
                                Circle()
                                    .fill(statusColor)
                                    .frame(width: 12, height: 12)
                                Text(invoice.status.uppercased())
                                    .font(.system(size: 12, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)
                        }
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
                        
                        // Main invoice content
                        VStack(spacing: 20) {
                            // Company Info
                            VStack(alignment: .leading, spacing: 8) {
                                Text("HONOLULU APPLIANCE REPAIR PRO")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("500 Ala Moana Blvd.")
                                    Text("Honolulu, HI 96813")
                                    Text("📞 808-518-2966")
                                }
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                            .cornerRadius(12)
                            
                            // Client & Date info
                            HStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("BILL TO")
                                        .font(.system(size: 11, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    Text(invoice.clientName)
                                        .font(.system(size: 14, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("DATE")
                                        .font(.system(size: 11, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    Text(dateFormatter.string(from: invoice.dateCreated))
                                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(16)
                            
                            Divider()
                                .padding(.horizontal, 0)
                            
                            // Line Items
                            VStack(spacing: 12) {
                                // Header
                                HStack(spacing: 0) {
                                    Text("DESCRIPTION")
                                        .font(.system(size: 11, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("QTY")
                                        .font(.system(size: 11, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        .frame(width: 40, alignment: .trailing)
                                    
                                    Text("AMOUNT")
                                        .font(.system(size: 11, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        .frame(width: 80, alignment: .trailing)
                                }
                                
                                Divider()
                                
                                // Items
                                ForEach(invoice.lineItems, id: \.id) { item in
                                    HStack(spacing: 0) {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(item.description)
                                                .font(.system(size: 13, weight: .semibold, design: .default))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            if !item.appliance.isEmpty {
                                                Text(item.appliance)
                                                    .font(.system(size: 11, weight: .regular, design: .default))
                                                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("\(Int(item.quantity))")
                                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .frame(width: 40, alignment: .trailing)
                                        
                                        Text(String(format: "$%.2f", item.amount))
                                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                            .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.0))
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    .padding(.vertical, 8)
                                }
                                
                                Divider()
                            }
                            .padding(.horizontal, 16)
                            
                            // Totals section
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Subtotal")
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    Spacer()
                                    Text(String(format: "$%.2f", invoice.subtotal))
                                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                                
                                HStack {
                                    Text("Tax (4.712%)")
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    Spacer()
                                    Text(String(format: "$%.2f", invoice.tax))
                                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                                
                                if invoice.discount > 0 {
                                    HStack {
                                        Text("Discount")
                                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        Spacer()
                                        Text(String(format: "- $%.2f", invoice.discount))
                                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                    }
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("TOTAL")
                                        .font(.system(size: 16, weight: .bold, design: .default))
                                    Spacer()
                                    Text(String(format: "$%.2f", invoice.total))
                                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                                        .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.0))
                                }
                            }
                            .padding(16)
                            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                            .cornerRadius(12)
                            
                            // Warranty info
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.0))
                                    Text("WARRANTY")
                                        .font(.system(size: 12, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("• 90-day labor warranty")
                                    Text("• 3-year parts warranty")
                                    Text("• 24/7 emergency service available")
                                }
                                .font(.system(size: 11, weight: .regular, design: .default))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                            .cornerRadius(12)
                        }
                        .padding(20)
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        Button(action: { showPDF = true }) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.down.doc")
                                Text("Export PDF")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color(red: 1.0, green: 0.45, blue: 0.0))
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .cornerRadius(12)
                        }
                        
                        Button(action: { }) {
                            HStack(spacing: 8) {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animateIn = true
                scale = 1.0
            }
        }
    }
    
    private var statusColor: Color {
        switch invoice.status.lowercased() {
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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct InvoiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InvoiceDetailView(invoice: Invoice.sample)
        }
    }
}
