# Honolulu Appliance Repair Pro Invoice App

A beautiful, professional 3D invoice management app built with SwiftUI for iOS.

## ✨ Features

### 📱 Premium UI/UX
- **3D Card Design** - Modern elevation and shadow effects
- **Smooth Animations** - Professional transitions and interactions
- **Beautiful Typography** - Carefully crafted font hierarchy
- **Brand Colors** - Orange accent color matching Honolulu Appliance Repair Pro
- **Dark Mode Support** - Fully optimized for light and dark themes

### 💼 Invoice Management
- **Professional Invoice Templates** - Industry-standard formatting
- **Real-time Calculations** - Automatic subtotal, tax, and total
- **Hawaii Tax** - Pre-configured 4.712% GET (Gross Excise Tax)
- **Warranty Information** - 90-day labor, 3-year parts warranty
- **Status Tracking** - Pending, Paid, Overdue states with visual indicators

### 🔧 Appliance Repair Specific
- **Appliance Types** - All major home appliances supported
- **Brand Support** - Pre-configured for all major brands
- **Service Tracking** - Call fees, labor hours, parts costs
- **Client Management** - Store and manage client information

### 📊 Dashboard
- **Quick Stats** - Total invoices and revenue at a glance
- **Invoice List** - Recent invoices with quick preview
- **Status Indicators** - Visual status badges
- **Quick Actions** - Create new invoice with one tap

## 🏗️ Architecture

```
Invoice/
├── App/
│   └── InvoiceApp.swift          (Main app entry point)
├── Models/
│   └── Invoice.swift              (Data models)
├── Views/
│   ├── ContentView.swift          (Dashboard)
│   └── InvoiceDetailView.swift    (Invoice display)
└── README.md
```

## 🎨 Design System

### Colors
- **Primary Orange**: `RGB(255, 115, 0)` - Action items and highlights
- **Neutral Gray**: `RGB(51, 51, 51)` - Text and primary content
- **Light Gray**: `RGB(240, 240, 240)` - Backgrounds
- **Accent Green**: `RGB(51, 204, 76)` - Success states
- **Accent Orange**: `RGB(255, 166, 0)` - Pending states
- **Accent Red**: `RGB(255, 51, 51)` - Overdue states

### Typography
- **Headlines**: System font, Bold, 28pt
- **Subheadings**: System font, Semibold, 14-18pt
- **Body**: System font, Regular, 12-14pt
- **Monospace**: Monospaced font for numbers and amounts

## 🚀 Getting Started

### Requirements
- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

### Installation
1. Clone the repository
2. Open `Invoice.xcodeproj`
3. Select your target device
4. Press Cmd+R to build and run

## 📖 Usage

### Creating an Invoice
1. Tap the "New" button in the top-right
2. Enter client information
3. Add line items (services, parts)
4. Review totals and tax calculation
5. Save invoice

### Viewing an Invoice
1. Tap on an invoice from the dashboard
2. View detailed invoice with 3D card effect
3. Export to PDF or share with client
4. Update payment status

## 🔮 Future Enhancements

- [ ] CloudKit sync for iCloud backup
- [ ] PDF generation and email
- [ ] Payment processing integration
- [ ] Multiple payment methods (Apple Pay, Stripe)
- [ ] Recurring invoices
- [ ] Expense tracking
- [ ] Time tracking
- [ ] Client portal
- [ ] Advanced reporting
- [ ] Multi-user support

## 📝 License

Private - Honolulu Appliance Repair Pro
