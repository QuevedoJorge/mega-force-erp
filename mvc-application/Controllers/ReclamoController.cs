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
    public class ReclamoController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Reclamo
        public ActionResult Index()
        {
            // Lista de reclamos usando SP
            var lista = db.Database.SqlQuery<Reclamo>("SP_MostrarReclamoTodo").ToList();

            // Si necesitas el Cliente en la vista, puedes resolverlo aquí
            foreach (var r in lista)
            {
                r.Cliente = db.Cliente.Find(r.codigoCliente);
            }

            return View(lista);
        }

        // GET: Reclamo/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigo", id);
            var reclamo = db.Database.SqlQuery<Reclamo>(
                "SP_BuscarReclamoXCodigo @codigo", pid
            ).FirstOrDefault();

            if (reclamo == null)
            {
                return HttpNotFound();
            }

            reclamo.Cliente = db.Cliente.Find(reclamo.codigoCliente);
            return View(reclamo);
        }

        // GET: Reclamo/Create
        public ActionResult Create()
        {
            // Combo de clientes (puedes usar SP_MostrarCliente si quieres solo activos)
            var clientes = db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList();
            ViewBag.codigoCliente = new SelectList(clientes, "codigoCliente", "nombre");
            return View();
        }

        // POST: Reclamo/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "descripcion,fecha,estado,codigoCliente")] Reclamo reclamo)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarReclamo @descripcion,@fecha,@estado,@codigoCliente",
                    new SqlParameter("@descripcion", reclamo.descripcion),
                    new SqlParameter("@fecha", reclamo.fecha),
                    new SqlParameter("@estado", reclamo.estado),
                    new SqlParameter("@codigoCliente", reclamo.codigoCliente)
                );

                return RedirectToAction("Index");
            }

            var clientes = db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList();
            ViewBag.codigoCliente = new SelectList(clientes, "codigoCliente", "nombre", reclamo.codigoCliente);
            return View(reclamo);
        }

        // GET: Reclamo/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigo", id);
            var reclamo = db.Database.SqlQuery<Reclamo>(
                "SP_BuscarReclamoXCodigo @codigo", pid
            ).FirstOrDefault();

            if (reclamo == null)
            {
                return HttpNotFound();
            }

            var clientes = db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList();
            ViewBag.codigoCliente = new SelectList(clientes, "codigoCliente", "nombre", reclamo.codigoCliente);

            return View(reclamo);
        }

        // POST: Reclamo/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo,descripcion,fecha,estado,codigoCliente")] Reclamo reclamo)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_ActualizarReclamo @codigo,@descripcion,@fecha,@estado,@codigoCliente",
                    new SqlParameter("@codigo", reclamo.codigo),
                    new SqlParameter("@descripcion", reclamo.descripcion),
                    new SqlParameter("@fecha", reclamo.fecha),
                    new SqlParameter("@estado", reclamo.estado),
                    new SqlParameter("@codigoCliente", reclamo.codigoCliente)
                );

                return RedirectToAction("Index");
            }

            var clientes = db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList();
            ViewBag.codigoCliente = new SelectList(clientes, "codigoCliente", "nombre", reclamo.codigoCliente);

            return View(reclamo);
        }

        // GET: Reclamo/Disable/5
        public ActionResult Disable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigo", id);
            var reclamo = db.Database.SqlQuery<Reclamo>(
                "SP_BuscarReclamoXCodigo @codigo", pid
            ).FirstOrDefault();

            if (reclamo == null)
            {
                return HttpNotFound();
            }

            reclamo.Cliente = db.Cliente.Find(reclamo.codigoCliente);
            return View(reclamo);
        }

        // POST: Reclamo/Disable/5
        [HttpPost, ActionName("Disable")]
        [ValidateAntiForgeryToken]
        public ActionResult DisableConfirmed(int id)
        {
            SqlParameter pid = new SqlParameter("@codigo", id);
            var reclamo = db.Database.SqlQuery<Reclamo>(
                "SP_BuscarReclamoXCodigo @codigo", pid
            ).FirstOrDefault();

            if (reclamo == null)
            {
                return HttpNotFound();
            }

            db.Database.ExecuteSqlCommand(
                "SP_ActualizarReclamo @codigo,@descripcion,@fecha,@estado,@codigoCliente",
                new SqlParameter("@codigo", reclamo.codigo),
                new SqlParameter("@descripcion", reclamo.descripcion),
                new SqlParameter("@fecha", reclamo.fecha),
                new SqlParameter("@estado", false),
                new SqlParameter("@codigoCliente", reclamo.codigoCliente)
            );

            return RedirectToAction("Index");
        }

        // GET: Reclamo/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SqlParameter pid = new SqlParameter("@codigo", id);
            var reclamo = db.Database.SqlQuery<Reclamo>(
                "SP_BuscarReclamoXCodigo @codigo", pid
            ).FirstOrDefault();

            if (reclamo == null)
            {
                return HttpNotFound();
            }

            reclamo.Cliente = db.Cliente.Find(reclamo.codigoCliente);
            return View(reclamo);
        }

        // POST: Reclamo/Enable/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarReclamo @codigo",
                new SqlParameter("@codigo", id)
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
