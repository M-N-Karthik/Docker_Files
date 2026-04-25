const express = require('express');
const { KeyValue } = require('../models/keyvalue');

const keyValueRouter = express.Router();

keyValueRouter.post('/', async (req, res) => {
  const { key, value } = req.body;

  if (!key || !value) {
    return res.status(400).json({ error: 'Both key and value are required' });
  }

  try {
    const existingKey = await KeyValue.findOne({ key });
    if (existingKey) {
      return res.status(400).json({ error: 'Key already exists' });
    }

    const keyValue = new KeyValue({ key, value });
    await keyValue.save();

    return res.status(201).json({ message: 'Key-Value pair stored successfully!!!!!' });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

keyValueRouter.get('/:key', async (req, res) => {
  const { key } = req.params;
  try {
    const doc = await KeyValue.findOne({ key });
    if (!doc) return res.status(404).json({ error: 'Key not found' });
    return res.json({ key: doc.key, value: doc.value });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

keyValueRouter.put('/:key', async (req, res) => {
  const { value } = req.body;
  if (!value) return res.status(400).json({ error: 'Value is required' });

  try {
    const doc = await KeyValue.findOneAndUpdate(
      { key: req.params.key },
      { value },
      { new: true }
    );
    if (!doc) return res.status(404).json({ error: 'Key not found' });
    return res.json({ key: doc.key, value: doc.value });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

keyValueRouter.delete('/:key', async (req, res) => {
  try {
    const doc = await KeyValue.findOneAndDelete({ key: req.params.key });
    if (!doc) return res.status(404).json({ error: 'Key not found' });
    return res.json({ message: 'Key deleted' });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

module.exports = { keyValueRouter };
