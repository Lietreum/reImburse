// authMiddleware.js
import jwt from 'jsonwebtoken';

const authenticateJWT = (req, res, next) => {
  const token = req.header('token');
  if (!token) return res.status(403).json({ message: 'Access denied' });

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: 'Invalid token' });
    req.user = user;
    next();
  });
};

export default authenticateJWT;
