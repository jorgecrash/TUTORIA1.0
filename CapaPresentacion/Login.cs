using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace CapaPresentacion
{
    public partial class Login : Form
    {
        public string usuario;
        public string clave;
        int m, mx, my;
        public Login()
        {
            InitializeComponent();
            //buttonIngresar.Focus();

        }

        public bool logins(string _usuario, string _clave)
        {
            try
            {

                using (SqlConnection conexion = new SqlConnection("Server=LAPTOP-IUT020T4;Integrated Security=yes; Database=Tutorias"))
                {
                    conexion.Open();
                    //_usuario = txtusuario.Text;
                    //_clave = txtcontraseña.Text;

                    using (SqlCommand cmd = new SqlCommand("SELECT * from Logins  WHERE Logins.Usuario='" + _usuario + "' AND Logins.Contraseña='" + _clave + "'", conexion))
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            MessageBox.Show("Login exitoso.");
                            obtenerusuario();
                            Close();
                            return true;

                        }
                        else
                        {
                            if (txtusuario.Text == "" && txtcontraseña.Text != "")
                            {
                                msgError("Llenar el campo usuario");
                                txtusuario.Focus();
                            }
                            else if (txtusuario.Text != "" && txtcontraseña.Text == "")
                            {
                                msgError("Llenar el campo contraseña");
                                txtcontraseña.Focus();
                            }
                            else if (txtusuario.Text == "" && txtcontraseña.Text == "")
                            {
                                msgError("Llenar ambos campos");
                                txtusuario.Focus();
                            }
                            else
                            {
                                msgError("Error Usuario i/o Contraseña");
                                txtusuario.Text = "";
                                txtcontraseña.Text = "";
                                txtusuario.Focus();
                            }
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                return false;
            }

        }

        private void msgError(string msg)
        {
            lblError.Text = msg;
            lblError.Visible = true;
        }

        private void buttonIngresar_Click(object sender, EventArgs e)
        {

        }
        public string obtenerusuario()
        {
            usuario = txtusuario.Text;
            return usuario;
        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {

        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void label4_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Esta opción estara disponible muy pronto :v");
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }

        private void btnIniciar_Click(object sender, EventArgs e)
        {
            usuario = txtusuario.Text;
            clave = txtcontraseña.Text;
            bool v = logins(usuario, clave);
            /*if (v == true)
            {
                MessageBox.Show("Login exitoso.");
            }
            else
            {
                MessageBox.Show("ERROR : Ingrese usuario y clave ");
            }*/
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void lblError_Click(object sender, EventArgs e)
        {

        }
        private void pictureBox2_MouseDown(object sender, MouseEventArgs e)
        {
            m = 1;
            mx = e.X;
            my = e.Y;
        }
        private void pictureBox2_Click_1(object sender, EventArgs e)
        {

        }
        private void pictureBox2_MouseMove(object sender, MouseEventArgs e)
        {
            if (m == 1)
            {
                this.SetDesktopLocation(MousePosition.X - mx, MousePosition.Y - my);
            }
        }

        private void pictureBox2_MouseUp(object sender, MouseEventArgs e)
        {
            m = 0;
        }
    }
}
