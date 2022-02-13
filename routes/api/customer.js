const express = require('express');
const router = express.Router();

const session = require(__module_dir + '/session.module.js');
const helper = require(__class_dir + '/helper.class.js');

const m$customer = require(`${__module_dir}/customer.module.js`);

router.get('/list', async function (req, res, next) {
  const list = await m$customer.getAllCustomer();
  helper.sendResponse(res, list);
});

router.post('/add', async (req, res, next) => {
  const data = await m$customer.addCustomer(req.body);
  helper.sendResponse(res, data);
});

router.post('/update', async (req, res, next) => {
  const data = await m$customer.updateCustomer(req.body);
  helper.sendResponse(res, data);
});

router.post('/delete/:id', async (req, res, next) => {
  const data = await m$customer.deleteCustomer(req.params.id);
  helper.sendResponse(res, data);
});

router.get('/:id', async (req, res, next) => {
  const data = await m$customer.getDetailCustomer(req.params.id);
  helper.sendResponse(res, data);
});

module.exports = router;
