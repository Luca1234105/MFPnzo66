# Base image Python slim aggiornata
FROM python:3.10-slim-bullseye

# Setta la directory di lavoro
WORKDIR /app

# Installa git, clona le repo, copia i file e pulisce tutto in un unico layer
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && git clone https://github.com/nzo66/mediaflow-proxy.git temp_mediaflow \
    && git clone https://github.com/nzo66/HF-MFP.git temp_hfmfp \
    && cp -r temp_mediaflow/* . 2>/dev/null || true \
    && cp -r temp_hfmfp/* . 2>/dev/null || true \
    && rm -rf temp_mediaflow temp_hfmfp \
    && rm -rf /var/lib/apt/lists/*

# Installa le dipendenze Python
RUN pip install --no-cache-dir -r requirements.txt

# Espone la porta dell'applicazione
EXPOSE 7860

# Avvia l'applicazione con uvicorn
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
