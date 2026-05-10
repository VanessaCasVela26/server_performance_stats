#!/bin/bash

export LC_ALL=C

# --- FUNCIONES ---

get_cpu_usage() {
    # Captura 1 y 2 con un pequeño intervalo para calcular el diferencial
    # Extraemos total e inactiva (columna 5) en una sola línea de awk
    read t1 i1 < <(awk '/^cpu / {s=0; for(i=2;i<=NF;i++) s+=$i; print s, $5}' /proc/stat)
    sleep 1
    read t2 i2 < <(awk '/^cpu / {s=0; for(i=2;i<=NF;i++) s+=$i; print s, $5}' /proc/stat)

    total_diff=$((t2 - t1))
    idle_diff=$((i2 - i1))

    usage=$(awk -v t=$total_diff -v i=$idle_diff 'BEGIN {
        if (t > 0) printf "%.2f", (1 - i/t) * 100
        else print "0.00"
    }')
    
    echo "CPU Usage: $usage%"
}

# Aquí podrías añadir más funciones en el futuro
# get_memory_usage() { ... }
# get_disk_usage() { ... }

run_all() {
    echo "--- Server Stats Total ---"
    get_cpu_usage
    # Aquí llamarías a las otras funciones cuando las crees
}

# --- LÓGICA DE EJECUCIÓN (MAIN) ---

# Revisamos qué argumento pasó el usuario
case "$1" in
    -c)
        # Si el usuario usa -c, ejecutamos solo CPU en un bucle
        while true; do
            get_cpu_usage
        done
        ;;
    "")
        # Si no hay argumentos, ejecuta todo el reporte en un bucle
        while true; do
            run_all
            echo "--------------------------"
            sleep 1 # Pausa entre reportes totales
        done
        ;;
    *)
        # Si el usuario pone algo que no conocemos
        echo "Uso: $0 {-c}"
        echo "  (sin argumentos): Ejecuta todas las estadísticas"
        echo "  -c: Ejecuta solo uso de CPU"
        exit 1
        ;;
esac
