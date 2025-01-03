## Instalación de Dependencias

El proyecto utiliza varias dependencias para implementar funcionalidades específicas. Asegúrate de instalar todas las dependencias necesarias antes de ejecutar el proyecto.

### Dependencias Requeridas

- **Flutter SDK**: [Instrucciones de instalación](https://docs.flutter.dev/get-started/install)
- **Paquetes de Dart**: Utilizados para gestionar el estado, hacer solicitudes HTTP, manejar IDs únicas, entre otros.

### Lista de Dependencias:

El archivo `pubspec.yaml` ya incluye todas las dependencias necesarias, como:
- `flutter_bloc`: Para la gestión del estado.
- `dio`: Para realizar solicitudes HTTP.
- `equatable`: Para comparar objetos de forma eficiente.
- `uuid`: Para generar identificadores únicos.
- `carousel_slider`: Para el carrusel de imágenes.
- `cupertino_icons`: Para los íconos de estilo iOS.
- `font_awesome_flutter`: Para utilizar los íconos de Font Awesome en Flutter.

### Pasos para Instalar las Dependencias

1. Asegúrate de haber clonado el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/ebookstore_app.git
   cd ebookstore_app


// Curl para firebase:

curl --location --request PUT 'https://ebook-store-app-1df29-default-rtdb.firebaseio.com/books.json' \
--header 'Content-Type: application/json' \
--data '{
  "0729dd20-c8b3-11ef-a67a-a12d799344fa": {
    "author": "Stieg Larsson",
    "description": "The electrifying follow-up to the phenomenal best seller The Girl with the Dragon Tattoo (\"An intelligent, ingeniously plotted, utterly engrossing thriller\" The Washington Post), and this time it is Lisbeth Salander, the troubled, wise-beyond-her-years genius hacker, who is the focus and fierce heart of the story.\n",
    "id": "0729dd20-c8b3-11ef-a67a-a12d799344fa",
    "imageUrl": "https://m.media-amazon.com/images/I/A1tAcwEMUSL._SL1500_.jpg",
    "language": "English",
    "pages": 500,
    "price": 7.90,
    "rate": 4.6,
    "title": "The Girl Who Kicked the Hornet'\''s Nest"
  },
  "29687460-c8b2-11ef-a67a-a12d799344fa": {
    "author": "Paula Hawkins",
    "description": "The debut psychological thriller that will forever change the way you look at other people'\''s lives, from the author of Into the Water and A Slow Fire Burning.\n",
    "id": "29687460-c8b2-11ef-a67a-a12d799344fa",
    "imageUrl": "https://m.media-amazon.com/images/I/91Ub4VK5Z6L._SL1500_.jpg",
    "language": "English",
    "pages": 400,
    "price": 9.90,
    "rate": 4.1,
    "title": "The Girl on the Train"
  },
  "3f41d1d0-c71a-11ef-8cdb-3101f6af8642": {
    "author": "George Martin",
    "description": "If the past is prologue, then George R. R. Martin’s masterwork—the most inventive and entertaining fantasy saga of our time—warrants one hell of an introduction. At long last, it has arrived with The World of Ice & Fire.\n",
    "id": "3f41d1d0-c71a-11ef-8cdb-3101f6af8642",
    "imageUrl": "https://m.media-amazon.com/images/I/71FSL3C24dL._SY522_.jpg",
    "language": "English",
    "pages": 500,
    "price": 4.50,
    "rate": 4.7,
    "title": "The world of ice and fire"
  },
  "50408eb0-c966-11ef-ace8-5912ed2a53b9": {
    "author": "Stieg Larrson",
    "description": "Lisbeth Salander—the heart of Larsson’s two previous novels—lies in critical condition, a bullet wound to her head, in the intensive care unit of a Swedish city hospital. ",
    "id": "50408eb0-c966-11ef-ace8-5912ed2a53b9",
    "imageUrl": "https://m.media-amazon.com/images/I/71zaFf+P9yL._SL1500_.jpg",
    "language": "English",
    "pages": 500,
    "price": 9.99,
    "rate": 5,
    "title": "The Girl Who Kicked the Hornets Nest"
  },
  "94a2dd10-c8b2-11ef-a67a-a12d799344fa": {
    "author": "Stieg Larsson",
    "description": "Harriet Vanger, a scion of one of Sweden'\''s wealthiest families disappeared over forty years ago. All these years later, her aged uncle continues to seek the truth. He hires Mikael Blomkvist, a crusading journalist recently trapped by a libel conviction, to investigate. He is aided by the pierced and tattooed punk prodigy Lisbeth Salander. Together they tap into a vein of unfathomable iniquity and astonishing corruption",
    "id": "94a2dd10-c8b2-11ef-a67a-a12d799344fa",
    "imageUrl": "https://m.media-amazon.com/images/I/71jy1t1N57L._SL1500_.jpg",
    "language": "English",
    "pages": 500,
    "price": 9.9,
    "rate": 4.5,
    "title": "The Girl with the Dragon Tattoo"
  },
  "a3155d00-c71d-11ef-8cdb-3101f6af8642": {
    "author": "Tolkien",
    "description": "“A glorious account of a magnificent adventure, filled with suspense and seasoned with a quiet humor that is irresistible... All those, young or old, who love a fine adventurous tale, beautifully told, will take The Hobbit to their hearts.”—The New York Times Book Review",
    "id": "a3155d00-c71d-11ef-8cdb-3101f6af8642",
    "imageUrl": "https://m.media-amazon.com/images/I/71UZKQ3-wCL._SL1500_.jpg",
    "language": "English",
    "pages": 300,
    "price": 11.90,
    "rate": 4.9,
    "title": "The Hobbit"
  },
  "aedbf5b0-c98c-11ef-acb3-6b751d85f144": {
    "author": "Dan Brown ",
    "description": "As Langdon and gifted French cryptologist Sophie Neveu sort through the bizarre riddles, they are stunned to discover a trail of clues hidden in the works of Leonardo da Vinci—clues visible for all to see and yet ingeniously disguised by the painter.",
    "id": "aedbf5b0-c98c-11ef-acb3-6b751d85f144",
    "imageUrl": "https://m.media-amazon.com/images/I/71wngh3UDSL._SL1500_.jpg",
    "language": "English",
    "pages": 500,
    "price": 19.68,
    "rate": 4.6,
    "title": "The Da Vinci Code"
  },
  "c4e1f000-c976-11ef-bb47-81741b503eb1": {
    "author": "Dan Brown ",
    "description": "Robert Langdon, Harvard professor of symbology, arrives at the ultramodern Guggenheim Museum Bilbao to attend the unveiling of a discovery that “will change the face of science forever.” The evening’s host is Edmond Kirsch, a forty-year-old billionaire and futurist, and one of Langdon’s first students.",
    "id": "c4e1f000-c976-11ef-bb47-81741b503eb1",
    "imageUrl": "https://m.media-amazon.com/images/I/719eG-eQY5L._SL1500_.jpg",
    "language": "English",
    "pages": 350,
    "price": 12.99,
    "rate": 4.3,
    "title": "Origin: A Novel"
  },
  "cad96030-c71c-11ef-8cdb-3101f6af8642": {
    "author": "Rolf Dobelli",
    "description": "Rolf Dobelli estudia los «errores de lógica» más imprevisibles para descubrir por qué sobrevaloramos nuestros propios conocimientos, por qué algo no se vuelve más cierto porque millones de personas lo consideran así, y por qué nos enfrascamos en teorías cuya falsedad está comprobada.\n",
    "id": "cad96030-c71c-11ef-8cdb-3101f6af8642",
    "imageUrl": "https://m.media-amazon.com/images/I/71DFtb5nDzL._SL1500_.jpg",
    "language": "Spanish",
    "pages": 100,
    "price": 11.92,
    "rate": 4.4,
    "title": "El arte de pensar"
  },
  "e4bb32f0-c968-11ef-b62f-27498fad894a": {
    "author": "Gillian Flynn ",
    "description": "On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunne’s fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nick’s clever and beautiful wife disappears.",
    "id": "e4bb32f0-c968-11ef-b62f-27498fad894a",
    "imageUrl": "https://m.media-amazon.com/images/I/71XPY7U9OML._SL1500_.jpg",
    "language": "English",
    "pages": 200,
    "price": 12.99,
    "rate": 4.2,
    "title": "Gone Girl A Novel"
  }
}'