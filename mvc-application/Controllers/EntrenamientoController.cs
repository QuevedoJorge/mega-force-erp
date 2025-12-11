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
    public class EntrenamientoController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Entrenamiento
        public ActionResult Index()
        {
            //var entrenamiento = db.Entrenamiento.Include(e => e.Trainer).Include(e => e.Locales);
            //return View(entrenamiento.ToList());
            var lista = db.SP_MostrarEntrenamientoTodo().ToList();
            return View(lista);
        }

        // GET: Entrenamiento/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var entrenamiento = db.Database.SqlQuery<SP_BuscarEntrenamientoXCodigo_Result>
                ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            if (entrenamiento == null)
            {
                return HttpNotFound();
            }
            return View(entrenamiento);
        }

        // GET: Entrenamiento/Create
        public ActionResult Create()
        {
            ViewBag.codigoTrainer = new SelectList(
                db.Database.SqlQuery<Trainer>("SP_MostrarTrainer").ToList(),
                "codigoTrainer", "nombre"
            );
            ViewBag.codigoLocal = new SelectList(
                db.Database.SqlQuery<Locales>("SP_MostrarLocales").ToList(),
                "codigoLocal", "tipo"
            );
            return View();
        }

        // POST: Entrenamiento/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoEntrenamiento,tipo," +
            "fechaHora,duracion,ubicacion,capacidadMaxima,estado,codigoTrainer,codigoLocal")] Entrenamiento entrenamiento)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarEntrenamiento @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7",
                    entrenamiento.tipo,
                    entrenamiento.fechaHora,
                    entrenamiento.duracion,
                    entrenamiento.ubicacion,
                    entrenamiento.capacidadMaxima,
                    entrenamiento.estado,
                    entrenamiento.codigoTrainer,
                    entrenamiento.codigoLocal
                );
                return RedirectToAction("Index");
            }
            ViewBag.codigoTrainer = new SelectList(
                db.Database.SqlQuery<Trainer>("SP_MostrarTrainer").ToList(),
                "codigoTrainer", "nombre"
            );
            ViewBag.codigoLocal = new SelectList(
                db.Database.SqlQuery<Locales>("SP_MostrarLocales").ToList(),
                "codigoLocal", "tipo"
            );
            return View();
        }

        // GET: Entrenamiento/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var entrenamiento = db.Database.SqlQuery<Entrenamiento>
                ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            if (entrenamiento == null)
            {
                return HttpNotFound();
            }
            ViewBag.codigoTrainer = new SelectList(
                db.Database.SqlQuery<Trainer>("SP_MostrarTrainer").ToList(),
                "codigoTrainer", "nombre"
            );
            ViewBag.codigoLocal = new SelectList(
                db.Database.SqlQuery<Locales>("SP_MostrarLocales").ToList(),
                "codigoLocal", "tipo"
            );
            return View(entrenamiento);
        }

        // POST: Entrenamiento/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoEntrenamiento,tipo,fechaHora,duracion," +
            "ubicacion,capacidadMaxima,estado,codigoTrainer,codigoLocal")] Entrenamiento entrenamiento)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                "SP_ActualizarEntrenamiento @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8",
                    entrenamiento.codigoEntrenamiento,
                    entrenamiento.tipo,
                    entrenamiento.fechaHora,
                    entrenamiento.duracion,
                    entrenamiento.ubicacion,
                    entrenamiento.capacidadMaxima,
                    entrenamiento.estado,
                    entrenamiento.codigoTrainer,
                    entrenamiento.codigoLocal
                );
                return RedirectToAction("Index");
            }
            ViewBag.codigoTrainer = new SelectList(
                db.Database.SqlQuery<Trainer>("SP_MostrarTrainer").ToList(),
                "codigoTrainer", "nombre"
            );
            ViewBag.codigoLocal = new SelectList(
                db.Database.SqlQuery<Locales>("SP_MostrarLocales").ToList(),
                "codigoLocal", "tipo"
            );
            return View(entrenamiento);
        }

        // GET: Entrenamiento/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //SqlParameter pid = new SqlParameter("@codigo", id);
            ////var entrenamiento = db.Database.SqlQuery<entrenamiento>
            //var entrenamiento = db.Database.SqlQuery<SP_BuscarEntrenamientoXCodigo_Result>
            //    ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            SqlParameter pid = new SqlParameter("@codigo", id);
            var entrenamiento = db.Database.SqlQuery<Entrenamiento>
                ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            if (entrenamiento == null)
            {
                return HttpNotFound();
            }
            return View(entrenamiento);
        }

        // POST: Entrenamiento/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_EliminarEntrenamiento @p0", id
            );
            return RedirectToAction("Index");
        }

        // GET: Entrenamiento/Delete/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //SqlParameter pid = new SqlParameter("@codigo", id);
            ////var entrenamiento = db.Database.SqlQuery<entrenamiento>
            //var entrenamiento = db.Database.SqlQuery<SP_BuscarEntrenamientoXCodigo_Result>
            //    ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            SqlParameter pid = new SqlParameter("@codigo", id);
            var entrenamiento = db.Database.SqlQuery<Entrenamiento>
                ("SP_BuscarEntrenamientoXCodigo @codigo", pid).FirstOrDefault();
            if (entrenamiento == null)
            {
                return HttpNotFound();
            }
            return View(entrenamiento);
        }

        // POST: Entrenamiento/Delete/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarEntrenamiento @p0", id
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
