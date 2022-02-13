const config = require(`${__config_dir}/app.config.json`);
const { debug } = config;
const helper = require(`${__class_dir}/helper.class.js`);
const mysql = new (require(`${__class_dir}/mariadb.class.js`))(config.db);
const __handler = require(__basedir + "/class/fileHandling.class.js");
const handler = new __handler(__basedir + "/public/image/parts/");

class _stok {
	// get all list stok
	listStok() {
		const sql = {
			query: `
			SELECT 
				s_stock.id_stock, 
				s_stock.id_produk, 
				s_stock.jumlah, 
				ref_produk.nama_produk, 
				ref_produk.harga 
			FROM 
				s_stock JOIN 
				ref_produk ON 
				ref_produk.id_produk = s_stock.id_produk `,
			params: [],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data: data,
				};
			})
			.catch((error) => {
				if (error.code == "EMPTY_RESULT") {
					return {
						status: false,
						error: "Data masih kosong!",
					};
				}

				if (debug) {
					console.error("karyawan list Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// get all list stok in
	listStokIn() {
		const sql = {
			query: `SELECT * FROM s_stock_in`,
			params: [],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data: data,
				};
			})
			.catch((error) => {
				if (error.code == "EMPTY_RESULT") {
					return {
						status: false,
						error: "Data masih kosong!",
					};
				}

				if (debug) {
					console.error("karyawan list Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// get all list stok out
	listStokOut() {
		const sql = {
			query: `SELECT * FROM s_stock_out`,
			params: [],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data: data,
				};
			})
			.catch((error) => {
				if (error.code == "EMPTY_RESULT") {
					return {
						status: false,
						error: "Data masih kosong!",
					};
				}

				if (debug) {
					console.error("karyawan list Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// add stok
	addStok(data) {
		const sql = {
			query: `INSERT INTO s_stock(id_stock, id_produk, jumlah) VALUES (?, ?, ?)`,
			params: [data.id_stock, data.id_produk, data.jumlah],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("addStok Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// add stok in
	addStokIn(data) {
		const sql = {
			query: `INSERT INTO s_stock_in(id_stock_in, id_produk, jumlah, tanggal) VALUES (?, ?, ?, ?)`,
			params: [data.id_stock_in, data.id_produk, data.jumlah, data.tanggal],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("addStok Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// add stok out
	addStokOut(data) {
		const sql = {
			query: `INSERT INTO s_stock_out(id_stock_out, id_produk, jumlah, tanggal) VALUES (?, ?, ?, ?)`,
			params: [data.id_stock_out, data.id_produk, data.jumlah, data.tanggal],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("addStok Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// update stok
	updateStok(data) {
		const sql = {
			query: `UPDATE s_stock SET id_produk = ?, jumlah = ? WHERE id_stock = ?`,
			params: [data.id_produk, data.jumlah, data.id_stock],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("updateKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// update stok in
	updateStokIn(data) {
		const sql = {
			query: `UPDATE s_stock_in SET id_produk = ?, jumlah = ?, tanggal = ? WHERE id_stock_in = ?`,
			params: [data.id_produk, data.jumlah, data.tanggal, data.id_stock_in],
		};
		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("updateKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// update stok out
	updateStokOut(data) {
		const sql = {
			query: `UPDATE s_stock_out SET id_produk = ?, jumlah = ?, tanggal = ? WHERE id_stock_out = ?`,
			params: [data.id_produk, data.jumlah, data.tanggal, data.id_stock_out],
		};
		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("updateKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// delete stok
	deleteStok(id) {
		const sql = {
			query: `DELETE FROM s_stock WHERE id_stock = ?`,
			params: [id],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("deleteKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// delete stok in
	deleteStokIn(id) {
		const sql = {
			query: `DELETE FROM s_stock_in WHERE id_stock_in = ?`,
			params: [id],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("deleteKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	// delete stok out
	deleteStokOut(id) {
		const sql = {
			query: `DELETE FROM s_stock_out WHERE id_stock_out = ?`,
			params: [id],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("deleteKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}

	getDetailKaryawan(id) {
		const sql = {
			query: `
				SELECT
					emp.id,
					emp.name,
					emp.date_birth,
					emp.position
				FROM tb_employee emp
				WHERE emp.id = ?`,
			params: [id],
		};

		return mysql
			.query(sql.query, sql.params)
			.then((data) => {
				return {
					status: true,
					data,
				};
			})
			.catch((error) => {
				if (debug) {
					console.error("getDetailKaryawan Error:", error);
				}

				return {
					status: false,
					error,
				};
			});
	}
}

module.exports = new _stok();
