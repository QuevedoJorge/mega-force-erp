using mvc_application;
using pe.com.megaforce;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace pe.com.megaforce.Controllers
{
    public class InscripcionController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Inscripcion
        public ActionResult Index()
        {
            var lista = db.SP_MostrarInscripcionTodo().ToList();
            return View(lista);
        }

        // GET: Inscripcion/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var inscripcion = db.Database.SqlQuery<SP_BuscarInscripcionXCodigo_Result>
                ("SP_BuscarInscripcionXCodigo @codigo", pid).FirstOrDefault();
            if (inscripcion == null)
            {
                return HttpNotFound();
            }
            return View(inscripcion);
        }

        // GET: Inscripcion/Create
        public ActionResult Create()
        {
            ViewBag.codigoCliente = new SelectList(
                db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList(),
                "codigoCliente", "nombre"
            );
            ViewBag.codigoEntrenamiento = new SelectList(
                db.Database.SqlQuery<Entrenamiento>("SP_MostrarEntrenamiento").ToList(),
                "codigoEntrenamiento", "tipo"
            );
            return View();
        }

        // POST: Inscripcion/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoInscripcion,codigoCliente," +
            "codigoEntrenamiento,estado")] Inscripciones inscripcion)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarInscripcion @p0, @p1, @p2",
                    inscripcion.codigoCliente,
                    inscripcion.codigoEntrenamiento,
                    inscripcion.estado
                );
                return RedirectToAction("Index");
            }
            ViewBag.codigoCliente = new SelectList(
                db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList(),
                "codigoCliente", "nombre"
            );
            ViewBag.codigoEntrenamiento = new SelectList(
                db.Database.SqlQuery<Entrenamiento>("SP_MostrarEntrenamiento").ToList(),
                "codigoEntrenamiento", "tipo"
            );
            return View();
        }

        // GET: Inscripcion/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var inscripcion = db.Database.SqlQuery<Inscripciones>
                ("SP_BuscarInscripcionXCodigo @codigo", pid).FirstOrDefault();
            if (inscripcion == null)
            {
                return HttpNotFound();
            }
            ViewBag.codigoCliente = new SelectList(
                db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList(),
                "codigoCliente", "nombre"
            );
            ViewBag.codigoEntrenamiento = new SelectList(
                db.Database.SqlQuery<Entrenamiento>("SP_MostrarEntrenamiento").ToList(),
                "codigoEntrenamiento", "tipo"
            );
            return View(inscripcion);
        }

        // POST: Inscripcion/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoInscripcion,codigoCliente," +
            "codigoEntrenamiento,,estado")] Inscripciones inscripciones)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_ActualizarInscripcion @p0, @p1, @p2, @p3",
                    inscripciones.codigoInscripcion,
                    inscripciones.codigoCliente,
                    inscripciones.codigoEntrenamiento,
                    inscripciones.estado
                );
                return RedirectToAction("Index");
            }
            ViewBag.codigoCliente = new SelectList(
                db.Database.SqlQuery<Cliente>("SP_MostrarCliente").ToList(),
                "codigoCliente", "nombre"
            );
            ViewBag.codigoEntrenamiento = new SelectList(
                db.Database.SqlQuery<Entrenamiento>("SP_MostrarEntrenamiento").ToList(),
                "codigoEntrenamiento", "tipo"
            );
            return View(inscripciones);
        }

        // GET: Inscripcion/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var inscripcion = db.Database.SqlQuery<SP_BuscarInscripcionXCodigo_Result>
                ("SP_BuscarInscripcionXCodigo @codigo", pid).FirstOrDefault();
            if (inscripcion == null)
            {
                return HttpNotFound();
            }
            return View(inscripcion);
        }

        // POST: Inscripcion/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_EliminarInscripcion @p0", id
            );
            return RedirectToAction("Index");
        }


        // GET: Inscripcion/Delete/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var inscripcion = db.Database.SqlQuery<SP_BuscarInscripcionXCodigo_Result>
                ("SP_BuscarInscripcionXCodigo @codigo", pid).FirstOrDefault();
            if (inscripcion == null)
            {
                return HttpNotFound();
            }
            return View(inscripcion);
        }

        // POST: Inscripcion/Delete/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarInscripcion @p0", id
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
