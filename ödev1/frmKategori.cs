using System;
using Npgsql;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace ödev1
{
    public partial class frmKategori : Form
    {
        public frmKategori()
        {
            InitializeComponent();
        }
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void frmKategori_Load(object sender, EventArgs e)
        {

        }

        private void ekle_Click(object sender, EventArgs e)
        {
            //kategori ekleme sorgusu buraya yazılacak
            baglanti.Open();
            string values = textBox1.Text;
            string sorgu = "insert into kategoribilgileri(kategori_ismi) values('" + textBox1.Text + "')";
            NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
            da.ExecuteNonQuery();
            textBox1.Text = "";
            MessageBox.Show("kategori eklendi");
            baglanti.Close();
        }
    }
}
