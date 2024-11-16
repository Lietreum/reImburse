// src/middleware/notFoundHandler.js
export default (req, res) => {
    res.status(404).json({
      error: {
        message: 'Not Found',
        solution: 'Please check the endpoint or URL you are trying to access.',
      },
    });
  };
  