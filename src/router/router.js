import { Router } from 'express';
import * as superAdmin from '../features/superAdmin/superAdminController.js';
import * as general from '../features/general/Account/AccountController.js';
import authenticateJWT from '../middleware/authMiddleware.js';

const router = Router();

// Super Admin Routes
router.post('/register', authenticateJWT, superAdmin.createAccount);
router.put('/edit/:userId', authenticateJWT, superAdmin.updateAccountHandler);
router.delete('/delete/:userId', authenticateJWT, superAdmin.deleteAccountHandler);
router.post('/assign-supervisor', authenticateJWT, superAdmin.assignSupervisor);
router.get('/hierarchy/:userId', authenticateJWT, superAdmin.getHierarchy);
router.get('/reports', authenticateJWT, superAdmin.getAllReports);

// General Routes
router.post('/login', general.loginAccount);

export default router;
