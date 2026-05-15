import express from 'express';

const app = express();

app.get('/health', (req, res) => {
  res.send('Health check passed!');
});

export { app };

export default app;
