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
    public partial class frmMusteriListeleme : Form
    {
        public frmMusteriListeleme()
        {
            InitializeComponent();
        }
        DataSet daset = new DataSet();
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");
        private void frmMusteriListeleme_Load_1(object sender, EventArgs e)
        {
            Kayıt_Goster();
        }
        private void Kayıt_Goster()
        {
            baglanti.Open();
            NpgsqlDataAdapter adrt = new NpgsqlDataAdapter("select *from musteri", baglanti);
            adrt.Fill(daset, "musteri");
            dataGridView1.DataSource = daset.Tables["musteri"];
            baglanti.Close();
        }
        private void btnGüncelle_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut = new NpgsqlCommand("update musteri set isim=@isim, telefon=@telefon, adres=@adres, email=@email where musteri_id=@musteri_id", baglanti);
            komut.Parameters.AddWithValue("@musteri_id", int.Parse( txtTc.Text));
            komut.Parameters.AddWithValue("@isim", txtAdSoyad.Text.ToString());
            komut.Parameters.AddWithValue("@telefon", txtTelefon.Text.ToString());
            komut.Parameters.AddWithValue("@adres", txtAdres.Text.ToString());
            komut.Parameters.AddWithValue("@email", txtEmail.Text.ToString());
            MessageBox.Show(komut.Parameters.ToString());
            komut.ExecuteNonQuery();
            baglanti.Close();
            daset.Tables["musteri"].DataSet.Clear();
            Kayıt_Goster();
            MessageBox.Show("Müşteri Kaydı Güncellendi");
            foreach(Control item in this.Controls)
            {
                if(item is TextBox)
                {
                    item.Text = ("");
                }
            }
        }
        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            txtTc.Text = dataGridView1.CurrentRow.Cells["musteri_id"].Value.ToString();
            txtAdSoyad.Text = dataGridView1.CurrentRow.Cells["isim"].Value.ToString();
            txtTelefon.Text = dataGridView1.CurrentRow.Cells["telefon"].Value.ToString();
            txtAdres.Text = dataGridView1.CurrentRow.Cells["adres"].Value.ToString();
            txtEmail.Text = dataGridView1.CurrentRow.Cells["email"].Value.ToString();
        }

        private void btnSil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            MessageBox.Show(dataGridView1.CurrentRow.Cells["musteri_id"].Value.ToString());
            NpgsqlCommand komut = new NpgsqlCommand("delete from musteri where musteri_id=" +int.Parse( dataGridView1.CurrentRow.Cells["musteri_id"].Value.ToString()), baglanti);
         
            komut.ExecuteNonQuery();
            baglanti.Close();
            daset.Tables["musteri"].Clear();
            Kayıt_Goster();
            MessageBox.Show("Kayıt Silindi");
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void txtTCara_TextChanged(object sender, EventArgs e)
        {
            DataTable tablo = new DataTable();
            baglanti.Open();
           NpgsqlDataAdapter adtr = new NpgsqlDataAdapter("select *from musteri where musteri_id= " +int.Parse(txtTCara.Text) ,baglanti);
            adtr.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();
        }
    }
}

    



