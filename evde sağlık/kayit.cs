using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace evde_sağlık
{
    public partial class kayit : Form
    {
        NpgsqlConnection conn;
        public kayit()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try { conn.Open(); }
            catch
            {
                MessageBox.Show("Bağlantı Sağlanılamadı", "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
                conn.Close();
                return;
            }
            try
            {
                int id = 0;
                NpgsqlCommand cmdd = new NpgsqlCommand("SELECT nextval('seq')",conn);
                DbDataReader reader = cmdd.ExecuteReader();
                if (reader.Read())
                {
                    id = Int32.Parse(reader.GetValue(0).ToString());
                    
                        
                }
                conn.CloseAsync().Wait();
                conn.Open();
                var cmd2 = new NpgsqlCommand(@"CREATE USER "+ textBox1.Text +" WITH PASSWORD '" + textBox2.Text +"'", conn);
                cmd2.ExecuteNonQuery();
                var cmd3 = new NpgsqlCommand(@"GRANT SELECT ON hasta,teshisler,randevu,users,uzmanlik,hekim,hekim_musaitlik TO " + textBox1.Text, conn);
                cmd3.ExecuteNonQuery();
                var cmd7 = new NpgsqlCommand(@"GRANT UPDATE,DELETE,INSERT ON hekim_musaitlik TO " + textBox1.Text, conn);
                cmd7.ExecuteNonQuery();
                var cmd8 = new NpgsqlCommand(@"GRANT UPDATE,DELETE,INSERT on randevu TO " + textBox1.Text, conn);
                cmd8.ExecuteNonQuery();
                var cmd = new NpgsqlCommand(@"INSERT INTO users (h_id,user_name,type) VALUES ("  +id + ",'" + textBox1.Text +  "','h')", conn);
                cmd.ExecuteNonQuery();
                var cmd1 = new NpgsqlCommand(@"INSERT INTO hasta (hid,isim,soyisim,adres,dtarihi) VALUES ("  +id + ",'"+textBox3.Text+"','"+textBox4.Text +"','" +textBox5.Text + "','" +textBox6.Text +"')", conn);
                cmd1.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString(),"Hata");
                conn.Close();
                return;
            }
            MessageBox.Show("Kayıt Başarılı");
            conn.Close();
        }

        private void kayit_Load(object sender, EventArgs e)
        {
            string connString =
    String.Format(
        "Server={0};Username={1};Database={2};Port={3};Password={4};SSLMode=Prefer",
        "127.0.0.1",
        "doktor",
        "evde_hizmet",
                "5432",
        "doktor");
            conn = new NpgsqlConnection(connString);
            
            
        }
    }
}
