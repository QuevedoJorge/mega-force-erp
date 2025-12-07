using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Remoting.Contexts;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace rest_application.Controllers
{
    [RoutePrefix("api/sancion")]
    public class SancionController : ApiController
    {
        SmarfitEntities db = new SmarfitEntities();

        [HttpGet]
        [Route("")]
        public IHttpActionResult FindAll()
        {
            var sanciones = db.SP_MostrarSancion().ToList();

            return Ok(sanciones);
        }

        [HttpGet]
        [Route("custom")]
        public IHttpActionResult FindAllActive()
        {
            var sanciones = db.SP_MostrarSancion().ToList();

            return Ok(sanciones);
        }

        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult findById(int id)
        {
            var sancion = db.SP_BuscarSancionXCodigo(id);
            return Ok(sancion);
        }

        [HttpPost]
        [Route("")]
        public IHttpActionResult Add([FromBody] Sancion obj)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            db.SP_RegistrarSancion(obj.fechaInicio, obj.fechaFin, obj.motivo, obj.codigoCliente, obj.estado);
            db.SaveChanges();
            return Ok(db.SP_MostrarSancion().ToList());
        }

        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult Update(int id, [FromBody] Sancion obj)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            db.SP_ActualizarSancion(id, obj.fechaInicio, obj.fechaFin, obj.motivo, obj.codigoCliente, obj.estado);
            db.SaveChanges();
            return Ok(db.SP_MostrarSancion().ToList());
        }

        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            db.SP_EliminarSancion(id);
            db.SaveChanges();
            return Ok(db.SP_MostrarSancion().ToList());
        }

        [HttpGet]
        [Route("code")]
        public IHttpActionResult FindNextCode(int id)
        {
            var siguienteCodigo = db.SP_CodigoSancion();
            return Ok(siguienteCodigo);
        }
    }
}