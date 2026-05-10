# server_performance_stats
Performance tool to check basic stats server. 
Project page URL: https://roadmap.sh/projects/server-stats

## Server Stats Monitor 

Este script de Shell es una herramienta ligera de monitoreo de recursos del sistema diseñada para entornos Linux. Permite visualizar el uso de la CPU en tiempo real, calculando la carga actual mediante la lectura directa de los contadores del kernel.

## Propósito

El objetivo principal de este script es proporcionar una métrica precisa del uso de CPU sin depender de herramientas externas pesadas. Es ideal para entornos de **Bioinformática** donde se requiere monitorear el impacto de procesos de análisis genómico (como alineamiento o ensamblaje) sobre los recursos del servidor.

A diferencia de comandos que muestran promedios históricos, este script calcula el diferencial ($\Delta$) de tiempo entre dos capturas para entregar el uso real del último segundo.

## Funcionalidades

- **Cálculo de CPU en tiempo real**: Procesa los ticks de reloj de `/proc/stat`.
- **Modularidad**: Estructurado mediante funciones de Bash para facilitar su expansión.
- **Interfaz de línea de comandos**: Soporta ejecución total o específica mediante banderas.
- **Precisión**: Utiliza `awk` para cálculos de punto flotante con precisión de dos decimales.

## Uso

### Requisitos
- Sistema operativo Linux/Unix.
- Intérprete `bash`.
- Herramientas estándar: `awk`, `cat`, `sleep`.

### Ejecución
Dale permisos de ejecución al archivo:
``` bash
chmod +x server-stats.sh
``` 

