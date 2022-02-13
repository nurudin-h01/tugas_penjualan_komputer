const express = require('express');
const router = express.Router();

const session = require(__module_dir + '/session.module.js');
const helper = require(__class_dir + '/helper.class.js');

const m$produk = require(`${__module_dir}/produk.module.js`);

router.get('/produk', async function (req, res, next) {
	const list = await m$produk.listProduk();
	helper.sendResponse(res, list);
});

router.post('/produk', async function (req, res, next) {
	const add = await m$produk.addProduk(req.body);
	helper.sendResponse(res, add);
});

router.get('/produk/:id', async function (req, res, next) {
	const detail = await m$produk.getDetailProduk(req.params.id)
	helper.sendResponse(res, detail)
});

router.put('/produk/:id', async function (req, res, next) {
	const update = await m$produk.updateProduk({...req.body, id: req.params.id});
	helper.sendResponse(res, update);
});

router.delete('/produk/:id', async function (req, res, next) {
	const deleteProduk = await m$produk.deleteProduk(req.params.id);
	helper.sendResponse(res, deleteProduk);
});

module.exports = router;
