// src/router/router.js
import { Router } from 'express';
import * as superAdmin from '../features/superAdmin/superAdminController.js';
import * as general from '../features/general/Account/AccountController.js';
import authenticateJWTFromCookie from '../middleware/authMiddleware.js';

const router = Router();
// turn of authenticatejwt if you hadnt registered super admin account or any
// Super Admin Routes (protected)
router.post('/register', authenticateJWTFromCookie, superAdmin.createAccount);
router.put('/edit/:userId', authenticateJWTFromCookie, superAdmin.updateAccountHandler);
router.delete('/delete/:userId', authenticateJWTFromCookie, superAdmin.deleteAccountHandler);
router.post('/assign-hirearchy', authenticateJWTFromCookie, superAdmin.assignHierarchy);
router.get('/hierarchy/:userId', authenticateJWTFromCookie, superAdmin.getHierarchyByUserId);
router.get('/reports', authenticateJWTFromCookie, superAdmin.getAllReports);

// General Routes
router.post('/login', general.loginAccount);

export default router;
