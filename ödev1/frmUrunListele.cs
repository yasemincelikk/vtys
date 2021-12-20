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
    public partial class frmUrunListele : Form
    {
        public frmUrunListele()
        {
            InitializeComponent();
        }
        DataSet daset = new DataSet();
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
        private void frmUrunListele_Load(object sender, EventArgs e)
        {
            Urun_Goster();
            kategorigetir();
        }
        private void Urun_Goster()
        { 
            baglanti.Open();
            NpgsqlDataAdapter adrt = new NpgsqlDataAdapter("select * from urun", baglanti);
            adrt.Fill(daset, "urun");
            dataGridView1.DataSource = daset.Tables["urun"];
            baglanti.Close();
        }
        private void btnYeniEkle_Click(object sender, EventArgs e)
        {
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
            NpgsqlCommand komut2 = new NpgsqlCommand("select * from markabilgileri where marka='" + comboMarka.Text.ToString() + "'", baglanti);
            NpgsqlDataReader dr = komut2.ExecuteReader();
            int marka_id = 0;
            while (dr.Read())
            {
                marka_id = int.Parse(dr["marka_id"].ToString());
            }
            baglanti.Close();
            baglanti.Open(); 
            NpgsqlCommand komut = new NpgsqlCommand("update urun set barkod_no=@barkod_no, kategori_id=@kategori_id, marka_id=@marka_id, alıs_fiyat=@alıs_fiyat,urun_adi=@urun_adi , satıs_fiyat=@satıs_fiyat, miktari=@miktari where barkod_no=@barkod_no", baglanti);
            komut.Parameters.AddWithValue("@barkod_no", txtBarkodNo.Text.ToString());
            komut.Parameters.AddWithValue("@kategori_id", kategori_id);
            komut.Parameters.AddWithValue("@marka_id", marka_id);
            komut.Parameters.AddWithValue("@alıs_fiyat",int.Parse( txtAlışFiyatı.Text.ToString()));
            komut.Parameters.AddWithValue("@urun_adi", txtUrunAdi.Text.ToString());
            komut.Parameters.AddWithValue("@miktari", int.Parse( txtMiktari.Text.ToString()));
            komut.Parameters.AddWithValue("@satıs_fiyat", int.Parse( txtSatışFiyatı.Text.ToString()));
            komut.ExecuteNonQuery();
            baglanti.Close();
            daset.Tables["urun"].DataSet.Clear();
            Urun_Goster();
            MessageBox.Show("Ürünler Güncellendi");
            foreach (Control item in this.Controls)
            {
                if (item is TextBox)
                {
                    item.Text = ("");
                }
            }
        }
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void txtBarkodNo_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboKetegori_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboMarka.Items.Clear();
            comboKetegori.Text = " ";
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

        private void comboMarka_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void txtUrunAdi_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAlışFiyatı_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtMiktari_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtSatışFiyatı_TextChanged(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
