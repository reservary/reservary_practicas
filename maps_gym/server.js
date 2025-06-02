const express = require('express');
const cors = require('cors');
const axios = require('axios');
const app = express();

const GOOGLE_API_KEY = 'AIzaSyAZW-Rn4h5BGgUZzFZXbYKTY6F1T9I8vWI';

app.use(cors());

// Endpoint para buscar lugares
app.get('/places', async (req, res) => {
  try {
    const { lat, lng } = req.query;
    const response = await axios.get(
      `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&radius=1500&type=gym&key=${GOOGLE_API_KEY}`
    );
    res.json(response.data);
  } catch (error) {
    console.error('Error en la búsqueda de lugares:', error);
    res.status(500).json({ error: 'Error al buscar lugares' });
  }
});

// Endpoint para obtener fotos
app.get('/photo', async (req, res) => {
  try {
    const { photoreference } = req.query;
    const response = await axios.get(
      `https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoreference}&key=${GOOGLE_API_KEY}`,
      { responseType: 'arraybuffer' }
    );
    
    // Establecer los headers correctos para la imagen
    res.set('Content-Type', 'image/jpeg');
    res.send(response.data);
  } catch (error) {
    console.error('Error al obtener la foto:', error);
    res.status(500).json({ error: 'Error al obtener la foto' });
  }
});

// Función para encontrar un puerto disponible
function findAvailablePort(startPort) {
  return new Promise((resolve, reject) => {
    const server = require('net').createServer();
    server.unref();
    server.on('error', (err) => {
      if (err.code === 'EADDRINUSE') {
        resolve(findAvailablePort(startPort + 1));
      } else {
        reject(err);
      }
    });
    server.listen(startPort, () => {
      server.close(() => {
        resolve(startPort);
      });
    });
  });
}

// Iniciar el servidor en un puerto disponible
async function startServer() {
  try {
    const port = await findAvailablePort(62474);
    app.listen(port, () => {
      console.log(`Servidor proxy corriendo en el puerto ${port}`);
      // Guardar el puerto en un archivo para que la aplicación Flutter pueda leerlo
      require('fs').writeFileSync('proxy_port.txt', port.toString());
    });
  } catch (error) {
    console.error('Error al iniciar el servidor:', error);
  }
}

startServer(); 