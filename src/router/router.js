import { Router } from 'express';
import { createAccount, loginAccount, deleteAccountHandler, updateAccountHandler } from '../features/superAdmin/superAdminController.js';
import authenticateJWT from '../middleware/authMiddleware.js';


const router = Router();

router.post('/register', createAccount);
router.post('/login', loginAccount);
router.put('/edit/:userId', authenticateJWT, updateAccountHandler);
router.delete('/delete/:userId', authenticateJWT, deleteAccountHandler);

export default router;
