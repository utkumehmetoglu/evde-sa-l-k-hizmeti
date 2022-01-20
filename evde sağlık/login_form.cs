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
    public partial class login_form : Form
    {
        private static string Host = "localhost";
        private static string DBname = "evde_hizmet";
        private static string Port = "5432";

        public login_form()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connString =
                String.Format(
                    "Server={0};Username={1};Database={2};Port={3};Password={4};SSLMode=Prefer",
                    Host,
                    textBox1.Text,
                    DBname,
                    Port,
                    textBox2.Text);
            var conn = new NpgsqlConnection(connString);
            try { conn.Open(); }
            catch(Exception ex)
            {
                MessageBox.Show("Bağlantı Sağlanılamadı" + ex.ToString(), "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
                conn.Close();
                return;
            }
            char  c = 'h';
            NpgsqlCommand cmdd = new NpgsqlCommand("SELECT type FROM users WHERE user_name= current_user", conn);
            DbDataReader reader = cmdd.ExecuteReader();
            if (reader.Read())
            {
                c = reader.GetValue(0).ToString()[0];


            }
            int did = 0;
            reader.Close();
            NpgsqlCommand cmd = new NpgsqlCommand("SELECT h_id FROM users WHERE user_name= current_user", conn);
            DbDataReader reader1 = cmd.ExecuteReader();
            if (reader.Read())
            {
                did = Int32.Parse(reader1.GetValue(0).ToString());


            }
            reader1.Close();
            if (c == 'd')
            {
                Form1 f = new Form1(conn,did);
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
            if (c == 'h')
            {
                Hasta h = new Hasta(conn, did);
                this.Hide();
                h.ShowDialog();
                this.Show();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            kayit k = new kayit();
            k.ShowDialog();
        }
    }
}
