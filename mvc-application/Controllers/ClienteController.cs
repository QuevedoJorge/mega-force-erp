using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using mvc_application;

namespace mvc_application.Controllers
{
    public class ClienteController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Cliente
        public ActionResult Index()
        {
            // Equivalente a SP_MostrarClienteTodo
            var lista = db.Database.SqlQuery<Cliente>("SP_MostrarClienteTodo").ToList();
            return View(lista);
        }

        // GET: Cliente/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigoCliente", id);
            var cliente = db.Database.SqlQuery<Cliente>(
                "SP_BuscarClienteXCodigo @codigoCliente", pid
            ).FirstOrDefault();

            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // GET: Cliente/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Cliente/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "nombre,correo,telefono,direccion,historialEntrenamientos,estado")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarCliente @nombre,@correo,@telefono,@direccion,@historialEntrenamientos,@estado",
                    new SqlParameter("@nombre", cliente.nombre),
                    new SqlParameter("@correo", cliente.correo),
                    new SqlParameter("@telefono", cliente.telefono),
                    new SqlParameter("@direccion", cliente.direccion),
                    new SqlParameter("@historialEntrenamientos", (object)cliente.historialEntrenamientos ?? string.Empty),
                    new SqlParameter("@estado", cliente.estado) // asumiendo bit / bool
                );

                return RedirectToAction("Index");
            }

            return View(cliente);
        }

        // GET: Cliente/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigoCliente", id);
            var cliente = db.Database.SqlQuery<Cliente>(
                "SP_BuscarClienteXCodigo @codigoCliente", pid
            ).FirstOrDefault();

            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // POST: Cliente/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoCliente,nombre,correo,telefono,direccion,historialEntrenamientos,estado")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_ActualizarCliente @codigoCliente,@nombre,@correo,@telefono,@direccion,@historialEntrenamientos,@estado",
                    new SqlParameter("@codigoCliente", cliente.codigoCliente),
                    new SqlParameter("@nombre", cliente.nombre),
                    new SqlParameter("@correo", cliente.correo),
                    new SqlParameter("@telefono", cliente.telefono),
                    new SqlParameter("@direccion", cliente.direccion),
                    new SqlParameter("@historialEntrenamientos", (object)cliente.historialEntrenamientos ?? string.Empty),
                    new SqlParameter("@estado", cliente.estado)
                );

                return RedirectToAction("Index");
            }
            return View(cliente);
        }

        // GET: Cliente/Disable/5
        public ActionResult Disable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigoCliente", id);
            var cliente = db.Database.SqlQuery<Cliente>(
                "SP_BuscarClienteXCodigo @codigoCliente", pid
            ).FirstOrDefault();

            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // POST: Cliente/Disable/5
        [HttpPost, ActionName("Disable")]
        [ValidateAntiForgeryToken]
        public ActionResult DisableConfirmed(int id)
        {
            // First, get the client's data
            SqlParameter pid = new SqlParameter("@codigoCliente", id);
            var cliente = db.Database.SqlQuery<Cliente>(
                "SP_BuscarClienteXCodigo @codigoCliente", pid
            ).FirstOrDefault();

            if (cliente == null)
            {
                return HttpNotFound();
            }

            // Now, update the state to inactive (assuming 0 is inactive)
            db.Database.ExecuteSqlCommand(
                "SP_ActualizarCliente @codigoCliente,@nombre,@correo,@telefono,@direccion,@historialEntrenamientos,@estado",
                new SqlParameter("@codigoCliente", cliente.codigoCliente),
                new SqlParameter("@nombre", cliente.nombre),
                new SqlParameter("@correo", cliente.correo),
                new SqlParameter("@telefono", cliente.telefono),
                new SqlParameter("@direccion", cliente.direccion),
                new SqlParameter("@historialEntrenamientos", (object)cliente.historialEntrenamientos ?? string.Empty),
                new SqlParameter("@estado", false) // Set state to inactive
            );

            return RedirectToAction("Index");
        }

        // GET: Cliente/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigoCliente", id);
            var cliente = db.Database.SqlQuery<Cliente>(
                "SP_BuscarClienteXCodigo @codigoCliente", pid
            ).FirstOrDefault();

            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // POST: Cliente/Enable/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarCliente @codigoCliente",
                new SqlParameter("@codigoCliente", id)
            );
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
