# **Windows Utility Menu (Batch Script)**

A lightweight, fast, and no-bullshit Windows utility script that bundles commonly-used system maintenance and quick-access commands into one clean interactive menu.

---

## **🚀 Features**

Use the menu number keys to execute the following actions:-
 1) Check for updates (winget)
 2) Update all packages (winget upgrade --all)
 3) Flush DNS cache (ipconfig /flushdns)
 4) Generate battery report (saved to Desktop)
 5) Reboot to BIOS (Requires Admin Permission)

### **🔋Battery Report (Auto-Save)**

* Generates a detailed battery health report
* Automatically detects your Desktop location

  * Supports **OneDrive Desktop** (`C:\Users\<user>\OneDrive\Desktop`)
  * Falls back to local Desktop if OneDrive isn’t present

### **Reboot Options**

* Restart normally
* Restart into **BIOS/UEFI firmware settings**

---

## **📁 File Included**

* `Utility.bat` — the main script.

---

## **🧩 Requirements**

* Windows 10 or 11
* Standard user permissions (Admin only needed for a few commands like battery report, flushdns, etc.)

---

## **▶️ How to Use**

1. Download or clone this repository.
2. Run `Utility.bat` by double-clicking it.
3. Use the menu number keys to execute actions.

---

## **📍 Battery Report Saving Logic**

The script checks your system in this order:

1. `C:\Users\<user>\OneDrive\Desktop`
2. `C:\Users\<user>\Desktop`

Battery report gets saved as:

```
battery-report-YYYYMMDD_HHMMSS.html
```

---

## **🛠️ Customization**

Feel free to modify the batch code. Everything is clean, commented, and easy to extend.

---

## **⚠️ Disclaimer**

This script runs built-in Windows utilities.
It **does not modify system files**, install anything, or make permanent configuration changes — but you’re responsible for how you use it.

---

## **📄 License**

MIT License (recommended for GitHub — you can add a LICENSE file).

---
