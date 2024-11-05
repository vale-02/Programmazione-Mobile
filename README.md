# Programmazione-Mobile

Brainiac è un'applicazione Flutter progettata per aiutare studenti universitari (triennali e magistrali) a organizzare e a prepararsi per gli esami.  L'app consente agli utenti di inserire i propri esami, suddivisi per anno accademico tenendo traccia dello stato di essi, e di raccogliere materiale di studio, come video e libri, per ogni esame.

![area di lavoro](https://github.com/user-attachments/assets/4e009b46-6912-440d-a8d2-600500aef541)  ![esame](https://github.com/user-attachments/assets/dc1f7c37-3b62-47bf-b80b-a894e4dc2275)  ![video](https://github.com/user-attachments/assets/6c91e1bc-0982-4aae-bf29-34e9f6047e36)  ![libri](https://github.com/user-attachments/assets/c49727dd-9e0e-47a6-a780-83feb4fb4ec2)  ![archivio](https://github.com/user-attachments/assets/6843875e-7032-45af-85f6-cbb9e8833d25)  ![miniplayer](https://github.com/user-attachments/assets/edaaff88-a9b8-4280-9bf1-91dd802d1851)

Funzionalità principali :
-
- Inserimento e modifica manuale anni di studio (da 1 a un massimo di 5)
- Inserire e modificare gli esami in base all'anno di studio
- Aggiungere manualmente o generarla automaticamente tramite Gemini AI
- Ricerca e raccolta di video e playlist da YouTube e di libri da Google Book
- Archivio locale per salvare tutte le modifiche apportate all'organizzazione degli esami e all'archivio contenente video, playlist e libri salvati


Tecnologie usate:
- 
- Hive: database locale per salvare anni di studio, esami, video, playlist e libri
- Gemini API: per la generazione automatica della descrizione dell'esame
- YouTube API: per cercare e visualizzare attraverso un miniplayer video e playlist conformi all'esame selezionato
- Google Book API: per cercare, visualizzare in anteprima e accedere all'acquisto di libri conformi all'esame selezionato

Installazione e configurazione:
-
1. Clonare il repository : git clone [https://github.com/vale-02/Programmazione-Mobile](https://github.com/vale-02/Programmazione-Mobile.git)
                           cd Programmazione-Mobile/brainiac
2. Installare le dipendenze : flutter pub get
3. Configurare le chiavi API : creare un file nella root del progetto .env e inserire le proprie chiavi nel seguente formato
   ```dotenv
   API_AI=[chiave_api_gemini_ai]
   API_YT=[chiave_api_youtube]
   API_BK=[chiave_api_google_book]
4. Esegui l'app su un emulatore oppure sul tuo telefono







