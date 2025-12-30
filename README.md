# CryptoSync – Proyecto de Práctica de Redes y Scripting 🛡️

![CryptoSync/CryptoSync.png](https://github.com/v1l4x/CryptoSync/blob/main/Cryptosync.png))


Este proyecto nació durante el curso de Redes IFCTO110 en INADECO, donde se nos pedía practicar cifrado y encriptación de archivos.  
Para aprovechar la oportunidad de aprender más, desarrollé este **script interactivo en Bash** que consolida varias funcionalidades de los ejercicios del curso y añade práctica de scripting real.

---
## 📚 Competencias Técnicas Adquiridas
- **Automatización de Seguridad:** Desarrollo de flujos lógicos para procesamiento de datos y verificación de integridad.  
- **Protección de Activos:** Implementación práctica de estándares criptográficos y manejo de hashes para asegurar información sensible.  
- **Calidad de Código:** Aplicación de modularidad (funciones), control de excepciones y gestión de señales de sistema.

## 🚦 Funcionalidades Principales
1. **Interfaz de Usuario (CLI):** menú interactivo que guía a través de las diferentes opciones de cifrado.  

2. **Gestión Criptográfica (GPG):**  
  - Generación de pares de claves asimétricas de forma automatizada.
  - Cifrado y descifrado de archivos utilizando claves públicas/privadas.
  - Exportación simplificada de claves públicas para intercambio seguro.
 
3. **Control de Integridad (MD5):**
- Generación de sumas de verificación (hashes) MD5.
- Modo de verificación automática para comprobar si un archivo ha sido alterado o corrompido.
   
## ❌ Robustez y Manejo de Errores
El script incluye una capa de validación que gestiona:

- Rutas de archivos inexistentes.

- Interrupciones inesperadas (mediante `trap` para `SIGINT`).

- Permisos de escritura en directorios de destino.

## 📋 Requisitos
- 🐧 Linux/Unix  
- #️⃣ Bash  
- 💾 GnuPG (GPG)  
- 🛡️ md5sum

## Instrucciones de uso:

1️⃣ Clona el repositorio:

```bash
git clone https://github.com/v1l4x/CryptoSync
```

2️⃣ Asignar permisos de ejecución:

```bash
chmod +x encriptador.sh
```

3️⃣ Ejecutar la herramienta:

```bash
./encriptador.sh
```

❗️ Este proyecto demuestra habilidades sólidas en scripting, automatización y manejo de datos críticos, competencias fundamentales para roles de Administración de Sistemas y Ciberseguridad.
