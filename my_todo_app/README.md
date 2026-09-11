# Aufgabenstellung:
# ToDo App

## Vollständige ToDo App entwickeln

Entwickle eine **vollständige ToDo-App** namens "My ToDo App" mit moderner Benutzeroberfläche und allen wichtigen Funktionen einer professionellen Aufgabenverwaltung. Diese App soll als deine persönliche Produktivitäts-Lösung dienen.

## Projekt-Übersicht
Du wirst eine funktionsreiche ToDo-App erstellen, die alle Aspekte des modernen App-Developments abdeckt: von der Grundstruktur über Datenpersistierung bis hin zu erweiterten Features wie Theming und Filtering.

## Implementierungsschritte

**1. Projektsetup und Grundstruktur:**
- Flutter-Projekt mit `flutter create -e my_todo_app` erstellen
- StatefulWidget als Hauptklasse implementieren  
- Scaffold mit AppBar ("My ToDo List") und Body konfigurieren
- FloatingActionButton zum Hinzufügen neuer Aufgaben
- Basis-Navigation und Routing vorbereiten

**2. Datenmodell und JSON-Serialisierung:**
- ToDo-Klasse mit allen Properties erstellen (id, title, description, isCompleted, createdAt, dueDate, priority)
- Priority Enum (low, medium, high) implementieren
- toMap() Methode für Shared Preferences Speicherung
- fromMap() Factory Constructor für Deserialisierung
- Error-Handling für beschädigte Daten

**3. Aufgaben-Liste UI:**
- ListView.builder für Performance bei vielen Aufgaben
- Card Widgets mit Material Design Schatten-Effekt
- ListTile oder custom Container für Aufgabeninhalte
- Checkbox für sofortiges Markieren als erledigt
- Visuelle Unterscheidung: erledigte vs. offene Aufgaben
- Empty State: "Keine Aufgaben vorhanden" bei leerer Liste
- Prioritäts-Indicators mit Farben/Icons

**4. CRUD-Operationen:**
- Dialog oder Bottom Sheet für Aufgaben-Eingabe
- Form mit Validierung (Titel Pflichtfeld)
- TextField für Titel und mehrzeilige Beschreibung
- DatePicker für optionales Fälligkeitsdatum
- Priority Selector (Dropdown/Segmented Control)
- Tap-to-edit: Antippen öffnet Bearbeitungsmodus
- Swipe-to-delete mit Dismissible Widget
- Bestätigungsdialog vor dem Löschen

**5. Datenpersistierung:**
- ToDoService Klasse für alle Speicher-Operationen erstellen
- saveToDoList() - JSON Serialisierung mit SharedPreferences
- loadToDoList() - Deserialisierung beim App-Start
- Automatisches Speichern bei jeder Änderung
- Error Handling für beschädigte oder fehlende Daten
- Laden der Daten in initState() der Hauptseite

**6. Filter und Sortierung:**
- Filter-Optionen: Alle, Offene, Erledigte, Überfällige Aufgaben
- Nach Priorität filtern (low/medium/high)
- Sortier-Optionen: Erstellungsdatum, Fälligkeitsdatum, Titel, Priorität
- AppBar mit Filter-Chips oder Dropdown-Menü
- Visuelle Anzeige des aktiven Filters
- Kombination von Filter und Sortierung ermöglichen

**7. Theming und UX:**
- Light/Dark Mode Toggle implementieren
- Material 3 Design System mit konsistenter Color Scheme
- SharedPreferences für Theme-Persistierung
- ValueNotifier für reaktives Theme-Management
- Icons für verschiedene Prioritäten und Kategorien
- Smooth Animations für alle Transitions
- Loading States bei async Operationen
- Responsive Design für verschiedene Bildschirmgrößen

## Technische Kernfeatures
**Datenmodell:**
- ToDo-Klasse mit vollständiger JSON-Serialisierung
- Prioritätssystem (low, medium, high)
- Persistente Speicherung mit SharedPreferences

**Benutzeroberfläche:**
- ListView.builder mit Card-Design für optimale Performance
- Intuitive CRUD-Operationen (Create, Read, Update, Delete)
- Swipe-to-delete und Tap-to-edit Funktionalität
- Empty State für leere Aufgabenliste

**Erweiterte Funktionen:**
- Umfassende Filter- und Sortieroptionen
- Light/Dark Mode mit Material 3 Design
- Responsive Design für verschiedene Bildschirmgrößen
- Performance-Optimierungen für große Datenmengen

## Erfolgs-Kriterien
✅ App startet zuverlässig und lädt gespeicherte Daten  
✅ Alle CRUD-Operationen funktionieren fehlerfrei  
✅ Filter und Sortierung arbeiten korrekt zusammen  
✅ Theme-Switching funktioniert in allen App-Zuständen  
✅ Performance bleibt gut bei vielen Aufgaben  
✅ App ist intuitiv bedienbar ohne Anleitung  
✅ Daten gehen auch bei App-Crash nicht verloren


