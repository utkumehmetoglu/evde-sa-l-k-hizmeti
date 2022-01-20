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
    public partial class doktor_teshislerim : Form
    {
        List <int> list = new List<int>();  
        NpgsqlConnection conn;
        int did;
        public doktor_teshislerim(NpgsqlConnection conn,int did)
        {
            this.conn = conn;
            this.did = did;
            InitializeComponent();
        }

        private void doktor_teshislerim_Load(object sender, EventArgs e)
        {
            conn.Close();
            conn.Open();
            var command = new NpgsqlCommand("SELECT DISTINCT h.isim,h.soyisim,t.teshis,t.recete,t.tarihsaat,t.hid FROM hekim d,teshisler t,hasta h WHERE t.did=" + did + " AND h.hid = t.hid", conn);
            var reader = command.ExecuteReader();
            while (reader.Read())
            {
                dataGridView1.Rows.Add(reader.GetString(0) + " " +  reader.GetString(1), reader.GetString(2), reader.GetString(3), reader.GetTimeStamp(4));
                list.Add(reader.GetInt32(5));

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Close();
            conn.Open();

            int selectedrowindex = dataGridView1.SelectedCells[0].RowIndex;
            DataGridViewRow selectedRow = dataGridView1.Rows[selectedrowindex];
            string recete = Convert.ToString(selectedRow.Cells["Reçete"].Value);
            string teshis = Convert.ToString(selectedRow.Cells["Teşhis"].Value);
            string ts = Convert.ToString(selectedRow.Cells["Tarihsaat"].Value);
            try
            {
                var command = new NpgsqlCommand("UPDATE teshisler SET recete='" + recete + "',teshis='" + teshis + "', tarihsaat=NOW() WHERE hid=" + list[selectedrowindex] + " AND tarihsaat='" + ts + "'", conn);

                command.ExecuteNonQuery();
                MessageBox.Show("Başarılı Bir şekilde değiştirildi", "Başarılı", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
