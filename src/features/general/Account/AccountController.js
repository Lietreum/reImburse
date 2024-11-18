import jwt from 'jsonwebtoken';
import * as accountService from './AccountService.js'

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

    // Generate the JWT token
    const token = jwt.sign(
      { userId: account.userId, role: account.role },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    // Set the token in a cookie
    res.cookie('token', token, {
      httpOnly: true, // Prevents client-side JavaScript from accessing the cookie
    });

    res.json({ message: 'Login successful', user: account });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};