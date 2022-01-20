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
    public partial class Hasta : Form
    {
        NpgsqlConnection conn;
        int hid;
        public Hasta(NpgsqlConnection conn,int hid)
        {
            this.conn = conn;
            this.hid = hid;
            InitializeComponent();
        }

        private void Hasta_Load(object sender, EventArgs e)
        {
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Randevu_al r = new Randevu_al(conn,hid);
            r.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Randevularım r = new Randevularım(conn,hid);
            r.ShowDialog(this);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            teshislerim t = new teshislerim(conn,hid);
            t.ShowDialog();
        }
    }
}
