import { Router } from 'express';
import * as superAdmin from '../features/superAdmin/superAdminController.js';
import * as general from '../features/general/Account/AccountController.js'
import authenticateJWT from '../middleware/authMiddleware.js';


const router = Router();

router.post('/register', superAdmin.createAccount);
router.put('/edit/:userId', authenticateJWT, superAdmin.updateAccountHandler);
router.delete('/delete/:userId', authenticateJWT, superAdmin.deleteAccountHandler);

router.post('/login', general.loginAccount);

export default router;
