using System;
using Npgsql;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ödev1
{
    public partial class frmSatis : Form
    {
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432 ; Database=Stok_takip;  user ID=postgres; password=196285");

        public frmSatis()
        {
            InitializeComponent();
        }
        //Npgsql Connection
        private void button6_Click(object sender, EventArgs e) //müşteri ekleme
        {
            frmMusteriEkle ekle = new frmMusteriEkle();
            ekle.ShowDialog();
            updateDataGrid();
        }

        public void frmSatis_Load(object sender, EventArgs e)
        {
            updateDataGrid();
        }
        public void updateDataGrid()
        {
            string sorgu = "select * from musterilistele()";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void button3_Click(object sender, EventArgs e)  //ürünekleme
        {
            frmUrunEkle urun = new frmUrunEkle();
            urun.ShowDialog();
            updateDataGrid();
        }

        private void button4_Click(object sender, EventArgs e) //kategori
        {
            frmKategori kategori  = new frmKategori();
            kategori.ShowDialog();
            updateDataGrid();
        }

        private void button7_Click(object sender, EventArgs e) //marka
        {
            frmMarka marka = new frmMarka();
            marka.ShowDialog();
            updateDataGrid();
        }
        private void button2_Click(object sender, EventArgs e) //ürünleri listeleme
        {
            frmUrunListele urunlistelee = new frmUrunListele();
            urunlistelee.ShowDialog();
            updateDataGrid();
        }
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button4_Click_1(object sender, EventArgs e)  //müşteri güncelleme
        {
            frmMusteriListeleme listele = new frmMusteriListeleme();
            listele.ShowDialog();
        }
    }
}
