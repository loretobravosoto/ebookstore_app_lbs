# 📚 **Ebookstore App**

Ebookstore es una aplicación desarrollada con Flutter para gestionar una tienda de libros electrónicos.

---

## **🚀 Instrucciones para inicializar el proyecto**

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/loretobravosoto/ebookstore_app_lbs.git
   cd ebookstore_app_lbs
   ```

2. **Instalar dependencias con Flutter:**

   Asegúrate de tener Flutter configurado en tu máquina. Luego, instala las dependencias necesarias desde el archivo `pubspec.yaml`:

   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**

   Una vez instaladas las dependencias, puedes iniciar la aplicación con el siguiente comando:

   ```bash
   flutter run
   ```

---

## **🔧 Dependencias Utilizadas**

Este proyecto utiliza las siguientes dependencias. Puedes encontrarlas en el archivo `pubspec.yaml`:

- `flutter_bloc`: Gestión del estado de la aplicación.
- `dio`: Para realizar solicitudes HTTP.
- `equatable`: Comparación eficiente de objetos.
- `uuid`: Generación de identificadores únicos.
- `carousel_slider`: Carrusel de imágenes en la interfaz.
- `cupertino_icons`: Íconos de estilo iOS.
- `font_awesome_flutter`: Íconos de Font Awesome.

### Requisitos previos:
- [Instalar Flutter SDK](https://docs.flutter.dev/get-started/install).
- Tener configurado un emulador o dispositivo físico para ejecutar la aplicación.

---

## **🌐 Cargar datos en Firebase**

Si deseas cargar datos iniciales en tu base de datos Firebase, puedes usar el siguiente comando `cURL`. Esto será útil para prellenar la base de datos con información de libros.

1. **Ejecuta el siguiente comando `cURL`:**

   ```bash
   curl --location --request PUT 'https://ebook-store-app-1df29-default-rtdb.firebaseio.com/books.json' \
   --header 'Content-Type: application/json' \
   --data '{
     "0729dd20-c8b3-11ef-a67a-a12d799344fa": {
       "author": "Stieg Larsson",
       "description": "The electrifying follow-up to the phenomenal best seller The Girl with the Dragon Tattoo...",
       "id": "0729dd20-c8b3-11ef-a67a-a12d799344fa",
       "imageUrl": "https://m.media-amazon.com/images/I/A1tAcwEMUSL._SL1500_.jpg",
       "language": "English",
       "pages": 500,
       "price": 7.90,
       "rate": 4.6,
       "title": "The Girl Who Kicked the Hornet's Nest"
     },
     "29687460-c8b2-11ef-a67a-a12d799344fa": {
       "author": "Paula Hawkins",
       "description": "The debut psychological thriller that will forever change the way you look at other people's lives...",
       "id": "29687460-c8b2-11ef-a67a-a12d799344fa",
       "imageUrl": "https://m.media-amazon.com/images/I/91Ub4VK5Z6L._SL1500_.jpg",
       "language": "English",
       "pages": 400,
       "price": 9.90,
       "rate": 4.1,
       "title": "The Girl on the Train"
     }
     // Agrega los demás libros aquí
   }'
   ```

   **Nota:** Asegúrate de reemplazar la URL del proyecto Firebase con la de tu propia base de datos.

---

## **📖 Notas Adicionales**

1. **Estructura del Proyecto:**
   - `lib/`: Contiene la lógica de la aplicación y los widgets.
   - `pubspec.yaml`: Archivo de configuración con las dependencias.

2. **Problemas comunes:**
   - Si encuentras errores relacionados con dependencias, intenta ejecutar:
     ```bash
     flutter clean
     flutter pub get
     ```

3. **Contribuciones:**
   Si deseas contribuir al proyecto, crea un "pull request" en el repositorio.

---

## **🛠️ Mantenimiento**

Si necesitas modificar o agregar datos adicionales, sigue los pasos para actualizar Firebase o consulta la documentación de Flutter.

---
