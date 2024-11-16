import jwt from 'jsonwebtoken';
import * as accountService from './AccountService.js'

// Login Account
export const loginAccount = async (req, res) => {
    try {
      const { username, password } = req.body;
  
      if (!username || !password) {
        return res.status(400).json({ error: 'Username and password are required' });
      }
  
      const account = await accountService.verifyAccount(username, password);
  
      if (!account) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
  
      const token = jwt.sign(
        { userId: account.userId, role: account.role },
        process.env.JWT_SECRET,
        { expiresIn: '1h' }
      );
  
      res.json({ message: 'Login successful', user: account, token });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };