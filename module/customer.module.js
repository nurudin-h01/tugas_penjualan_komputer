const config = require(`${__config_dir}/app.config.json`);
const { debug } = config;
const helper = require(`${__class_dir}/helper.class.js`);
const mysql = new (require(`${__class_dir}/mariadb.class.js`))(config.db);
const __handler = require(__basedir + '/class/fileHandling.class.js');
const handler = new __handler(__basedir + '/public/image/parts/');

class _customer {
  getDetailCustomer(id) {
    const sql = {
      query: `SELECT * FROM d_customer WHERE id_customer = ?`,
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
          console.error('getDetailCustomer Error:', error);
        }

        return {
          status: false,
          error,
        };
      });
  }

  deleteCustomer(id) {
    const sql = {
      query: `DELETE FROM d_customer WHERE id_customer = ?`,
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
          console.error('deleteCustomer Error:', error);
        }

        return {
          status: false,
          error,
        };
      });
  }

  updateCustomer(data) {
    const sql = {
      query: `UPDATE d_customer SET nama_depan=?, nama_belakang=?, alamat=?, email=? WHERE id_customer = ?`,
      params: [
        data.nama_depan,
        data.nama_belakang,
        data.alamat,
        data.email,
        data.id,
      ],
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
          console.error('updateCustomer Error:', error);
        }

        return {
          status: false,
          error,
        };
      });
  }

  addCustomer(data) {
    const sql = {
      query: `INSERT INTO d_customer (nama_depan, nama_belakang, alamat, email) values (?, ?, ?, ?)`,
      params: [data.nama_depan, data.nama_belakang, data.alamat, data.email],
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
          console.error('addCustomer Error:', error);
        }

        return {
          status: false,
          error,
        };
      });
  }

  getAllCustomer() {
    const sql = {
      query: `SELECT * FROM d_customer`,
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
          console.error('getAllCustomer Error:', error);
        }

        return {
          status: false,
          error,
        };
      });
  }
}

module.exports = new _customer();
