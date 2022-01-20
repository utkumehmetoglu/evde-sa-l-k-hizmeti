namespace evde_sağlık
{
    partial class doktor_teshislerim
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.Bölüm = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Teşhis = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Reçete = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Tarihsaat = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Bölüm,
            this.Teşhis,
            this.Reçete,
            this.Tarihsaat});
            this.dataGridView1.Location = new System.Drawing.Point(3, 3);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(843, 398);
            this.dataGridView1.TabIndex = 1;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(732, 407);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(106, 40);
            this.button1.TabIndex = 2;
            this.button1.Text = "Değiştir";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Bölüm
            // 
            this.Bölüm.HeaderText = "Hasta Adı";
            this.Bölüm.Name = "Bölüm";
            this.Bölüm.Width = 200;
            // 
            // Teşhis
            // 
            this.Teşhis.HeaderText = "Teşhis";
            this.Teşhis.Name = "Teşhis";
            this.Teşhis.Width = 200;
            // 
            // Reçete
            // 
            this.Reçete.HeaderText = "Reçete";
            this.Reçete.Name = "Reçete";
            this.Reçete.Width = 200;
            // 
            // Tarihsaat
            // 
            this.Tarihsaat.HeaderText = "Tarih/Saat";
            this.Tarihsaat.Name = "Tarihsaat";
            this.Tarihsaat.Width = 200;
            // 
            // doktor_teshislerim
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(850, 459);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.dataGridView1);
            this.Name = "doktor_teshislerim";
            this.Text = "doktor_teshislerim";
            this.Load += new System.EventHandler(this.doktor_teshislerim_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridViewTextBoxColumn Bölüm;
        private System.Windows.Forms.DataGridViewTextBoxColumn Teşhis;
        private System.Windows.Forms.DataGridViewTextBoxColumn Reçete;
        private System.Windows.Forms.DataGridViewTextBoxColumn Tarihsaat;
    }
}