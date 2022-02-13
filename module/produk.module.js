const config = require(`${__config_dir}/app.config.json`);
const {debug} = config;
const helper = require(`${__class_dir}/helper.class.js`);
const mysql = new(require(`${__class_dir}/mariadb.class.js`))(config.db);
const __handler = require(__basedir + '/class/fileHandling.class.js');
const handler = new __handler(__basedir + '/public/image/parts/');

class _produk{
	deleteProduk(id_produk){
		const sql = {
			query: `DELETE FROM ref_produk WHERE id_produk = ?`,
			params: [id_produk]
		}

		return mysql.query(sql.query, sql.params)
			.then(data => {
				return {
					status: true,
					data
				}
			}).catch(error => {
				if (debug) {
					console.error('deleteProduk Error:', error);
				}

				return {
					status: false,
					error
				}
			})
	}

	updateProduk(data){
		const sql = {
			query: `UPDATE ref_produk SET nama_produk = ?, harga = ? WHERE id_produk = ?`,
			params: [data.nama_produk, data.harga, data.id_produk]
		}

		return mysql.query(sql.query, sql.params)
			.then(data => {
				return {
					status: true,
					data
				}
			}).catch(error => {
				if(debug){
					console.error('updateProduk Error:', error);
				}

				return {
					status: false,
					error
				}
			})
	}

	addProduk(data){
		const sql = {
			query: `INSERT INTO ref_produk(id_produk, nama_produk, harga) VALUES (?, ?, ?)`,
			params: [data.id_produk, data.nama_produk, data.harga]
		}

		return mysql.query(sql.query, sql.params)
			.then(data => {
				return {
					status: true,
					data
				}
			}).catch(error => {
				if(debug){
					console.error('addProduk Error:', error);
				}

				return {
					status: false,
					error
				}
			})
	}

	getDetailProduk(id_produk){
		const sql = {
			query: `
				SELECT
					prd.id_produk,
					prd.nama_produk,
					prd.harga
				FROM ref_produk prd
				WHERE prd.id_produk = ?`,
			params: [id_produk]
		}

		return mysql.query(sql.query, sql.params)
			.then(data => {
				return {
					status: true,
					data
				}
			}).catch(error => {
				if (debug) {
					console.error("getDetailProduk Error:", error);
				}

				return {
					status: false,
					error
				}
			})
	}

	listProduk(){
		const sql = {
			query: `
				SELECT
					prd.id_produk,
					prd.nama_produk,
					prd.harga
				FROM ref_produk prd
				WHERE 1`,
			params: [],
		};

		return mysql.query(sql.query, sql.params)
			.then(data => {
				return {
					status: true,
					data: data 
				};
			})
			.catch(error => {
				if (error.code == "EMPTY_RESULT") {
					return {
						status: false,
						error: "Data masih kosong!"
					}
				}

				if(debug){
					console.error('Produk list Error:', error);
				}

				return {
					status: false,
					error,
				};
			});
	};
}

module.exports = new _produk();
