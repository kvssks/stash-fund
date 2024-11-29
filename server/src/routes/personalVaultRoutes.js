const express = require('express');
const router = express.Router();
const { chipIn, chipOut, getVaultDetails } = require('../controller/personalVaultController');

router.post('/chip-in', chipIn);
router.post('/chip-out', chipOut);
router.get('/:userId', getVaultDetails);

module.exports = router;
