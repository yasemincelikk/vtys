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
    public partial class frmUrunEkle : Form
    {
        public frmUrunEkle()
        {
            InitializeComponent();
        }
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");
        private void kategorigetir()
        {
            baglanti.Open();
            NpgsqlCommand komut = new NpgsqlCommand("select *from kategoribilgileri", baglanti);
            komut.ExecuteNonQuery();
            NpgsqlDataReader dr = komut.ExecuteReader();
            while (dr.Read())
            {
                comboKetegori.Items.Add(dr[1].ToString());
            }
            baglanti.Close();
        }

        private void textBox18_TextChanged(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter_1(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter_2(object sender, EventArgs e)
        {

        }

        private void frmUrunEkle_Load(object sender, EventArgs e)
        {
            kategorigetir();
        }

        private void button1_Click(object sender, EventArgs e) //ürün ekleme
        {
            baglanti.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("select * from markabilgileri where marka='"+comboMarka.Text.ToString()+"'", baglanti);
            NpgsqlDataReader dr = komut2.ExecuteReader();
            int marka_id=0;
            while (dr.Read())
            {
                marka_id=int.Parse(dr["marka_id"].ToString());
            }
            baglanti.Close();
            baglanti.Open();
            NpgsqlCommand komut3 = new NpgsqlCommand("select * from kategoribilgileri where kategori_ismi='" + comboKetegori.Text.ToString() + "'", baglanti);
            NpgsqlDataReader dr2 = komut3.ExecuteReader();
            int kategori_id = 0;
            while (dr2.Read())          
            {
                kategori_id = int.Parse(dr2["kategori_id"].ToString());
            }
            baglanti.Close();
            baglanti.Open();
            string values = "'"+txtBarkodNo.Text.ToString() + "','" + txtUrunAdi.Text.ToString() + "','" + txtMiktari.Text.ToString() + "','" + txtAlışFiyatı.Text.ToString() + "','" + txtSatışFiyatı.Text.ToString() + "'," +marka_id+ "," + kategori_id;
            string sorgu = "insert into urun(barkod_no,urun_adi,miktari,alıs_fiyat,satıs_fiyat,marka_id,kategori_id) values(" + values + ");";
            NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
            da.ExecuteNonQuery();
            MessageBox.Show("Ürün Eklendi");
            baglanti.Close();
        }
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e) 
        {
            comboMarka.Items.Clear();
            comboKetegori.Text=" ";
            baglanti.Open();
            NpgsqlCommand komut = new NpgsqlCommand("select * from markabilgileri ", baglanti);
            komut.ExecuteNonQuery();
            NpgsqlDataReader dr = komut.ExecuteReader();
            while (dr.Read())
            {
                comboMarka.Items.Add(dr["marka"].ToString());
            }
            baglanti.Close();
        }
        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
          
        }

        private void btnBarkodNo_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUrunAdi_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAlışFiyatı_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtSatışFiyatı_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
