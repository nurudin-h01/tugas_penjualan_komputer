const express = require("express");
const router = express.Router();

const session = require(__module_dir + "/session.module.js");
const helper = require(__class_dir + "/helper.class.js");

const m$penjualan = require(`${__module_dir}/penjualan.module.js`);

router.get("/list", async function (req, res, next) {
	const list = await m$penjualan.getAllPenjualan();
	helper.sendResponse(res, list);
});

router.get("/:id", async function (req, res, next) {
	const id = req.params.id;
	const detail = await m$penjualan.getDetailPenjualan(id);
	helper.sendResponse(res, detail);
});

router.put("/update", async function (req, res, next) {
	const data = await m$penjualan.updatePenjualan(req.body);
	helper.sendResponse(res, data);
});

router.post("/add", async function (req, res, next) {
	const data = await m$penjualan.addPenjualan(req.body);
	helper.sendResponse(res, data);
});

router.delete("/delete/:id", async function (req, res, next) {
	const data = await m$penjualan.deletePenjualan(req.params.id);
	helper.sendResponse(res, data);
});

module.exports = router;
