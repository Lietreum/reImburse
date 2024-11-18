// src/app.js
import express from 'express';
import cors from 'cors';
import router from './router/router.js';
import errorHandler from './middleware/errorHandler.js';
import notFoundHandler from './middleware/notFoundHandler.js';
import cookieParser from 'cookie-parser';

const app = express();
const PORT = process.env.PORT || 3000;  // Use default port if not set

// Konfigurasi CORS
const corsOptions = {
  origin: ['http://localhost:3000', 'http://localhost:5173'], // Ganti dengan domain frontend Anda
  Credential: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'], // Metode yang diizinkan
  allowedHeaders: ['Content-Type', 'Authorization'], // Header yang diizinkan
};

app.use(cookieParser());
app.use(cors(corsOptions)); // Middleware CORS
app.use(express.json()); // Middleware JSON parser
app.use('/api', router); // Routing utama

// Middleware untuk error handling
app.use(errorHandler);
app.use(notFoundHandler);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

export default app;
