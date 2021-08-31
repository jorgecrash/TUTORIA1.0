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
        SqlConnection conexion = new SqlConnection("Server=LAPTOP-IUT020T4;Integrated Security=yes; Database=Tutorias");
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
             if(i==1)
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
