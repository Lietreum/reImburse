import express from 'express';
import router from './router/router.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Use express.json() to parse JSON bodies
app.use(express.json());
app.use('/api', router);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
