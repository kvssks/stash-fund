const GroupVault = require('../models/groupVaultModel');
const PersonalVault = require('../models/personalVaultModel');

exports.chipIn = async (req, res) => {
  try {
    const { groupId, userId, amount, source } = req.body;

    if (source === 'personal_vault') {
      const personalVault = await PersonalVault.findOne({ userId });

      if (!personalVault || personalVault.amount < amount) {
        return res.status(400).json({ success: false, message: 'Insufficient personal funds' });
      }

      personalVault.amount -= amount;
      await personalVault.save();
    }

    const groupVault = await GroupVault.findOneAndUpdate(
      { groupVaultId: groupId },
      { 
        $inc: { totalAmount: amount },
        $push: { contributions: { user: userId, contribution: amount } }
      },
      { new: true }
    );

    res.status(200).json({ success: true, groupVault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.chipOut = async (req, res) => {
  try {
    const { groupId, userId, amount } = req.body;

    const groupVault = await GroupVault.findOne({ groupVaultId: groupId });

    if (!groupVault || groupVault.totalAmount < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient group funds' });
    }

    const personalVault = await PersonalVault.findOneAndUpdate(
      { userId },
      { $inc: { amount } },
      { new: true, upsert: true }
    );

    groupVault.totalAmount -= amount;
    await groupVault.save();

    res.status(200).json({ success: true, groupVault, personalVault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.createGroupVault = async (req, res) => {
  try {
    const { groupVaultId, name, purpose } = req.body;
    const groupVault = await GroupVault.create({ groupVaultId, name, purpose });
    res.status(201).json({ success: true, groupVault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.getGroupVaultDetails = async (req, res) => {
  try {
    const { groupId } = req.params;
    const groupVault = await GroupVault.findOne({ groupVaultId: groupId });
    if (!groupVault) {
      return res.status(404).json({ success: false, message: 'Group vault not found' });
    }
    res.status(200).json({ success: true, groupVault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
