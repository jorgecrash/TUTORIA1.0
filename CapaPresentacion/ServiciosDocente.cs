
using CapaEntidades; 
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaPresentacion
{
    public class ServiciosDocente
    {
        SqlConnection conexion = new SqlConnection("Server=.;Integrated Security=yes; Database=Tutorias");
        public virtual bool eliminar_docente(string codigo)
        {
            int i;
            conexion.Open();
            SqlCommand cmd = new SqlCommand("SP_ELIMINARDOCENTE", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();
            cmd.Parameters.AddWithValue("@IDDOCENTE", codigo);
            i = cmd.ExecuteNonQuery();
            conexion.Close();
            if (i == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        //SERVISE  DOCENTE EDITAR
        public virtual bool Editar_Docente(string codigo, string Nombres, string Apellido, string Titulo, string Faculad, string EProfesional, string Categoria)
        {
            int i;
            conexion.Open();
            SqlCommand cmd = new SqlCommand("SP_EDITARDOCENTE", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();
            cmd.Parameters.AddWithValue("@IDDOCENTE", codigo);
            i = cmd.ExecuteNonQuery();
            cmd.Parameters.AddWithValue("@NOMBRES", Nombres);
            cmd.Parameters.AddWithValue("@APELLIDOS", Apellido);
            cmd.Parameters.AddWithValue("@TITULO", Titulo);
            cmd.Parameters.AddWithValue("@FACULTAD", Faculad);
            cmd.Parameters.AddWithValue("@EPROFESIONAL", EProfesional);
            cmd.Parameters.AddWithValue("@EPROFESIONAL", Categoria);
            conexion.Close();
            if (i == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /*
        public int SearchDocente(E_Docente docente)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand("SP_BUSCARDOCENTE", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@BUSCAR", docente.Search);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(tabla);

            conexion.Close();
            return tabla.Rows.Count;
        }*/


        public virtual bool AgregarDocente(string codigo, string nombre, string apellido, string titulo, string facultad, string escuela, string categoria)
        {
            int ejecucion;


            conexion.Open();
            SqlCommand cmd = new SqlCommand("SP_INSERTARDOCENTE", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IDDOCENTE", codigo);
            cmd.Parameters.AddWithValue("@NOMBRES", nombre);
            cmd.Parameters.AddWithValue("@APELLIDOS", apellido);
            cmd.Parameters.AddWithValue("@TITULO", titulo);
            cmd.Parameters.AddWithValue("@FACULTAD", facultad);
            cmd.Parameters.AddWithValue("@EPROFESIONAL", escuela);
            cmd.Parameters.AddWithValue("@CATEGORIA", categoria);
            conexion.Open();

            ejecucion = cmd.ExecuteNonQuery();
            conexion.Close();
            if (ejecucion == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

    }
}
