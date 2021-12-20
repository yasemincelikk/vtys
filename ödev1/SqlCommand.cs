using Npgsql;

namespace ödev1
{
    internal class SqlCommand
    {
        private string v;
        private NpgsqlConnection baglanti;

        public SqlCommand(string v, NpgsqlConnection baglanti)
        {
            this.v = v;
            this.baglanti = baglanti;
        }
    }
}