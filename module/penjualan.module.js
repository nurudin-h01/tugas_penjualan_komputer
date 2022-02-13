const config = require(`${__config_dir}/app.config.json`);
const { debug } = config;
const helper = require(`${__class_dir}/helper.class.js`);
const mysql = new (require(`${__class_dir}/mariadb.class.js`))(config.db);
const __handler = require(__basedir + '/class/fileHandling.class.js');
const handler = new __handler(__basedir + '/public/image/parts/');

class _penjualan {
  getAllPenjualan() {
    const sql = {
      query: `SELECT * FROM s_penjualan`,
      data: [],
    };

    return mysql
      .query(sql.query, sql.data)
      .then((data) => {
        return {
          status: true,
          data,
        };
      })
      .catch((error) => {
        if (debug) {
          console.error('getAllPenjualan Error:', error);
        }
        return {
          status: false,
          error,
        };
      });
  }

  getDetailPenjualan(id) {
    const sql = {
      query: `SELECT * FROM s_penjualan WHERE id_penjualan = ?`,
      data: [id],
    };

    return mysql
      .query(sql.query, sql.data)
      .then((data) => {
        return {
          status: true,
          data: data[0],
        };
      })
      .catch((error) => {
        if (debug) {
          console.error('getDetailPenjualan Error:', error);
        }
        return {
          status: false,
          error,
        };
      });
  }

  updatePenjualan(data) {
    const sql = {
      query: `UPDATE s_penjualan SET id_customer = ?, id_produk = ?, jumlah_produk = ? WHERE id_penjualan = ?`,
      data: [
        data.id_customer,
        data.id_produk,
        data.jumlah_produk,
        data.id_penjualan,
      ],
    };

    return mysql
      .query(sql.query, sql.data)
      .then((data) => {
        return {
          status: true,
          data,
        };
      })
      .catch((error) => {
        if (debug) {
          console.error('updatePenjualan Error:', error);
        }
        return {
          status: false,
          error,
        };
      });
  }

  addPenjualan(data) {
    const sql = {
      query: `INSERT INTO s_penjualan (id_customer, id_produk, jumlah_produk) VALUES (?, ?, ?)`,
      data: [data.id_customer, data.id_produk, data.jumlah_produk],
    };

    return mysql
      .query(sql.query, sql.data)
      .then((data) => {
        return {
          status: true,
          data,
        };
      })
      .catch((error) => {
        if (debug) {
          console.error('addPenjualan Error:', error);
        }
        return {
          status: false,
          error,
        };
      });
  }

  deletePenjualan(id) {
    const sql = {
      query: `DELETE FROM s_penjualan WHERE id_penjualan = ?`,
      data: [id],
    };

    return mysql
      .query(sql.query, sql.data)
      .then((data) => {
        return {
          status: true,
          data,
        };
      })
      .catch((error) => {
        if (debug) {
          console.error('deletePenjualan Error:', error);
        }
        return {
          status: false,
          error,
        };
      });
  }
}

module.exports = new _penjualan();
