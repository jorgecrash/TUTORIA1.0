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
        public void EliminarDocenteExisteValido12()
        {
            Mock<ServiciosDocente> D = new Mock<ServiciosDocente>();
            string CodDocente = "D0001";
            bool Expected = true;
            D.Setup(a => a.eliminar_docente(It.IsAny<string>())).Returns(true);
            bool actual = D.Object.eliminar_docente(CodDocente);
            Assert.AreEqual(actual, Expected);
        }



    }
}
