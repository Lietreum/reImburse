// src/middleware/errorHandler.js
export default (err, req, res, next) => {
    const now = new Date().toISOString();
    console.error(`[${now}] Error occurred:
      Type: ${err.name || 'Unknown Error'}
      Message: ${err.message || 'No message provided'}
      Stack Trace: ${err.stack || 'No stack trace available'}
      URL: ${req.url}
      Method: ${req.method}
      IP: ${req.ip}
      User-Agent: ${req.get('User-Agent')}
    `);
  
    if (err.message.includes("Cannot read properties of undefined")) {
      res.status(400).json({
        error: {
          message: "A property was accessed on an undefined object. Please check your request data or server logic.",
          details: err.message,
          solution: "Ensure all required data is provided and objects are defined before accessing properties."
        }
      });
    } else {
      res.status(err.status || 500).json({
        error: {
          message: err.message || 'Internal Server Error',
          ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
          solution: "Please try again later or contact support."
        },
      });
    }
  };
  