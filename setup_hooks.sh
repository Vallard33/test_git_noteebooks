#!/bin/sh
echo "Configuration des hooks et synchronisation initiale..."

# 1. Vérification de Jupytext
if ! python -c "import jupytext" &> /dev/null; then
    echo "Jupytext n'est pas installé. Installation en cours..."
    pip install jupytext
fi

# 2. Installation des hooks
echo "Installation des hooks Git..."
cp hooks/* .git/hooks/
chmod +x .git/hooks/*

# 3. Création ou mise à jour des fichiers .ipynb à partir des _ntb.py
echo "Création ou mise à jour des fichiers .ipynb..."
for py_file in *_ntb.py; do
    ipynb_file="${py_file/_ntb.py/.ipynb}"
    echo "Traitement de $py_file -> $ipynb_file..."
    python -m jupytext --to notebook "$py_file" --output "$ipynb_file"
done

echo "Configuration terminée !"
