// src/app.js
import express from 'express';
import router from './router/router.js';
import errorHandler from './middleware/errorHandler.js';
import notFoundHandler from './middleware/notFoundHandler.js';

const app = express();
const PORT = process.env.PORT || 3000;  // Use default port if not set

app.use(express.json());
app.use('/api', router);

// Middleware setup
app.use(errorHandler);
app.use(notFoundHandler);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

export default app;
