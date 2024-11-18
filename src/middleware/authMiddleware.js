// src/middleware/authMiddleware.js
import jwt from 'jsonwebtoken';

const authenticateJWTFromCookie = (req, res, next) => {
  const token = req.cookies.authToken;

  if (!token) {
    return res.status(401).json({ message: 'Authentication token is missing' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Attach user info (userId and role) to the request
    next();
  } catch (error) {
    res.status(403).json({ message: 'Invalid token' });
  }
};

export default authenticateJWTFromCookie;
