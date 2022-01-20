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
    public partial class Form1 : Form
    {
        NpgsqlConnection conn;
        int did;
        public Form1(NpgsqlConnection conn,int did)
        {
            this.conn = conn;
            this.did = did;
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            doktor_randevu doktor_Randevu = new doktor_randevu(conn,did);
            doktor_Randevu.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            teshis_koy t = new teshis_koy(conn, did,-1);
            t.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            doktor_teshislerim dt = new doktor_teshislerim(conn, did);
            dt.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            İstatistik i = new İstatistik(conn, did);
            i.Show();
        }
    }
}
