using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace evde_sağlık
{
    public partial class doktor_randevu : Form
    {
        NpgsqlConnection conn;int did;
        List<int> l = new List<int>();
        public doktor_randevu(NpgsqlConnection conn,int did)
        {
            this.conn = conn;this.did = did;
            InitializeComponent();
            l= new List<int>();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void doktor_randevu_Load(object sender, EventArgs e)
        {
            conn.CloseAsync();
            conn.Open();
            var command = new NpgsqlCommand("SELECT h.isim, h.soyisim, r.tarih, r.saat , h.adres, r.durum , h.hid FROM randevu r , hasta h" +
                " WHERE r.did="+did + " AND  r.hid = h.hid"  , conn);
            command.Parameters.AddWithValue("d", did.ToString());
            var reader = command.ExecuteReader();
            while (reader.Read())
            {
                dataGridView1.Rows.Add(reader.GetString(0) +" " + reader.GetString(1), reader.GetDate(2) + " " + reader.GetString(3), reader.GetString(4),reader.GetString(5));
                l.Add(reader.GetInt32(6));
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            teshis_koy t = new teshis_koy(conn, did,l[dataGridView1.SelectedCells[0].RowIndex]);
            t.ShowDialog();
        }
    }
}
