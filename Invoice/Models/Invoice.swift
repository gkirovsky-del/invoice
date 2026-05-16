import Foundation

struct Invoice: Identifiable {
    let id: Int
    let clientName: String
    let clientEmail: String
    let clientPhone: String
    let dateCreated: Date
    let dueDate: Date
    let lineItems: [LineItem]
    let status: String // "pending", "paid", "overdue"
    let notes: String
    
    var subtotal: Double {
        lineItems.reduce(0) { $0 + $1.amount }
    }
    
    var tax: Double {
        subtotal * 0.04712 // Hawaii GET tax
    }
    
    var discount: Double {
        0
    }
    
    var total: Double {
        subtotal + tax - discount
    }
    
    static let sample = Invoice(
        id: 1001,
        clientName: "John Doe",
        clientEmail: "john@example.com",
        clientPhone: "808-555-1234",
        dateCreated: Date(),
        dueDate: Date().addingTimeInterval(30 * 24 * 60 * 60),
        lineItems: [
            LineItem(id: UUID(), description: "Refrigerator Repair", appliance: "Samsung French Door", quantity: 1, unitPrice: 250),
            LineItem(id: UUID(), description: "Compressor Replacement", appliance: "Parts & Labor", quantity: 1, unitPrice: 450),
            LineItem(id: UUID(), description: "Service Call Fee", appliance: "", quantity: 1, unitPrice: 75)
        ],
        status: "pending",
        notes: "24/7 emergency service available. Please contact us for any questions."
    )
}

struct LineItem: Identifiable {
    let id: UUID
    let description: String
    let appliance: String
    let quantity: Double
    let unitPrice: Double
    
    var amount: Double {
        quantity * unitPrice
    }
}
