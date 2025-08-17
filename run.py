from fastapi import FastAPI
from mediaflow_proxy.main import app as mediaflow_app  # Import principale MediaFlow

# Crea l'app FastAPI principale
main_app = FastAPI()

# Aggiungi solo le rotte effettive, escludendo eventualmente static e root
for route in mediaflow_app.routes:
    if route.path != "/":  # Puoi adattare per escludere solo i percorsi static se vuoi
        main_app.router.routes.append(route)

# Avvio dell'applicazione
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        main_app,
        host="0.0.0.0",
        port=7860,
        # workers=4  # Se vuoi, puoi attivare più worker in produzione
    )
