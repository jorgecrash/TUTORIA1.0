using CapaDatos;
using CapaEntidades;
using CapaNegocio;
using System.Data.SqlClient;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System.Data;
using System.Collections.Generic;
using CapaPresentacion;

namespace PruebasFormulario
{
    [TestClass]
    public class PruebasMoqDocente
    {
        [TestMethod]
        public void EliminarDocenteExisteValido()
        {
            Mock<ServiciosDocente> D = new Mock<ServiciosDocente>();
            string CodDocente = "D0001";
            bool Expected = true;
            D.Setup(a => a.eliminar_docente(It.IsAny<string>())).Returns(true);
            bool actual = D.Object.eliminar_docente(CodDocente);
            Assert.AreEqual(actual, Expected);
        }

        //_____________________________________TETS MOQ EDITAR_________________________________//
        [TestMethod]
        public void Editar_docente_codnoValido()
        {
            Mock<ServiciosDocente> D = new Mock<ServiciosDocente>();
            string codigo = "1";
            string Nombres = "Ana Roci";
            string Apellido = "Cardenas Maita";
            string Titulo = "Magister en Ciencias en Sistemas de Informacion";
            string Facultad = "Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica";
            string EProfesional = "Ingenieria Informatica y de Sistemas";
            string Categoria = "NOMBRADO";
            bool Expected = false;
            D.Setup(a => a.Editar_Docente(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>())).Returns(false);
            bool actual = D.Object.Editar_Docente(codigo, Nombres, Apellido, Titulo, Facultad, EProfesional, Categoria);
            Assert.AreEqual(actual, Expected);
        }






    }
}
