using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Npgsql;
namespace ödev1
{
    public partial class frmMarka : Form
    {
        public frmMarka()
        {
            InitializeComponent();
        }
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");
      
       /* private void kategorigetir()
        {
            baglanti.Open();
            NpgsqlCommand komut = new NpgsqlCommand("select *from kategoribilgileri", baglanti);
            komut.ExecuteNonQuery();
            NpgsqlDataReader dr = komut.ExecuteReader();
            while (dr.Read())
            {
                comboBox1.Items.Add(dr[1].ToString());
            }
            baglanti.Close();
        }*/

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            /*baglanti.Open();
            string values = comboBox1.Text;
            string sorgu = "insert into markabilgileri(kategori_ismi,marka) values('" + comboBox1.Text + "' , '"+ textBox2.Text + "')";
            NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
            da.ExecuteNonQuery();
            comboBox1.Text = "";
            textBox2.Text = "";
            MessageBox.Show("marka eklendi");
            baglanti.Close();*/
            baglanti.Open();
            string values = textBox2.Text;
            string sorgu = "insert into markabilgileri(marka) values('" + textBox2.Text + "')";
            NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
            da.ExecuteNonQuery();
            textBox2.Text = "";
            MessageBox.Show("Marka eklendi");
            baglanti.Close();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmMarka_Load(object sender, EventArgs e)
        {
            //kategorigetir();
        }
    }
}
