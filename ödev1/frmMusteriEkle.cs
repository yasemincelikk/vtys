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
    public partial class frmMusteriEkle : Form
    {
        public frmMusteriEkle()
        {
            InitializeComponent();
        }
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");
        
        private void frmMusteriEkle_Load(object sender, EventArgs e)
        {

        }
       
        private void button1_Click(object sender, EventArgs e)
        {
            //müşteri ekleme sorgusu buraya yazılacak
            baglanti.Open();
            string values = txtTc.Text + ",'" + txtAdSoyad.Text + "','" + txtTelefon.Text.ToString() + "','" + txtAdres.Text.ToString() + "','" + txtEmail.Text.ToString()+ "'";
            string sorgu = "insert into musteri(musteri_id,isim,telefon,adres,email) values(" + values + ");";
          //  MessageBox.Show(sorgu);
            NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
            da.ExecuteNonQuery();
            MessageBox.Show("kayit eklendi");
            baglanti.Close();
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
