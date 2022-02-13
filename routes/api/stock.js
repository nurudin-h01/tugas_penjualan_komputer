const express = require("express");
const router = express.Router();

const helper = require(__class_dir + "/helper.class.js");

const m$stok = require(`${__module_dir}/stok.module.js`);

router.get("/stok", async function (req, res, next) {
	const list = await m$stok.listStok();
	helper.sendResponse(res, list);
});

router.get("/stok-in", async function (req, res, next) {
	const list = await m$stok.listStokIn();
	helper.sendResponse(res, list);
});

router.get("/stok-out", async function (req, res, next) {
	const list = await m$stok.listStokOut();
	helper.sendResponse(res, list);
});

router.post("/stok", async function (req, res, next) {
	const add = await m$stok.addStok(req.body);
	helper.sendResponse(res, add);
});

router.post("/stok-in", async function (req, res, next) {
	const add = await m$stok.addStokIn(req.body);
	helper.sendResponse(res, add);
});

router.post("/stok-out", async function (req, res, next) {
	const add = await m$stok.addStokOut(req.body);
	helper.sendResponse(res, add);
});

router.get("/:id", async function (req, res, next) {
	const detail = await m$stok.getDetailstok(req.params.id);
	helper.sendResponse(res, detail);
});

router.put("/stok", async function (req, res, next) {
	const update = await m$stok.updateStok({
		...req.body,
		id: req.params.id,
	});
	helper.sendResponse(res, update);
});

router.put("/stok-in", async function (req, res, next) {
	const update = await m$stok.updateStokIn({
		...req.body,
		id: req.params.id,
	});
	helper.sendResponse(res, update);
});

router.put("/stok-out", async function (req, res, next) {
	const update = await m$stok.updateStokOut({
		...req.body,
		id: req.params.id,
	});
	helper.sendResponse(res, update);
});

router.delete("/stok/:id", async function (req, res, next) {
	const deletestok = await m$stok.deleteStok(req.params.id);
	helper.sendResponse(res, deletestok);
});

router.delete("/stok-in/:id", async function (req, res, next) {
	const deletestok = await m$stok.deleteStokIn(req.params.id);
	helper.sendResponse(res, deletestok);
});

router.delete("/stok-out/:id", async function (req, res, next) {
	const deletestok = await m$stok.deleteStokOut(req.params.id);
	helper.sendResponse(res, deletestok);
});

module.exports = router;
