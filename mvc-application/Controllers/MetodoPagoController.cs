using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using mvc_application;

namespace mvc_application.Controllers
{
    public class MetodoPagoController : Controller
    {
        private SmarfitEntities db = new SmarfitEntities();

        // GET: MetodoPago
        public ActionResult Index()
        {
            var lista = db.SP_MostrarMetodoPagoTodo().ToList();
            return View(lista);
        }

        // GET: MetodoPago/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var metodo = db.SP_BuscarMetodoPagoXCodigo(id).FirstOrDefault();
            if (metodo == null)
            {
                return HttpNotFound();
            }
            return View(metodo);
        }

        // GET: MetodoPago/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: MetodoPago/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idMetodoPago,nombre,descripcion,estado")] MetodoPago metodo)
        {
            if (ModelState.IsValid)
            {
                db.SP_RegistrarMetodoPago(metodo.nombre, metodo.descripcion, metodo.estado.ToString());
                return RedirectToAction("Index");
            }

            return View(metodo);
        }

        // GET: MetodoPago/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var metodo = db.SP_BuscarMetodoPagoXCodigo(id).FirstOrDefault();
            if (metodo == null)
            {
                return HttpNotFound();
            }
            return View(metodo);
        }

        // POST: MetodoPago/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idMetodoPago,nombre,descripcion,estado")] MetodoPago metodo)
        {
            if (ModelState.IsValid)
            {
                db.SP_ActualizarMetodoPago(metodo.idMetodoPago, metodo.nombre, metodo.descripcion, metodo.estado.ToString());
                return RedirectToAction("Index");
            }
            return View(metodo);
        }

        // GET: MetodoPago/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var metodo = db.SP_BuscarMetodoPagoXCodigo(id).FirstOrDefault();
            if (metodo == null)
            {
                return HttpNotFound();
            }
            return View(metodo);
        }

        // POST: MetodoPago/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.SP_EliminarMetodoPago(id);
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
        // GET: MetodoPago/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var metodo = db.SP_BuscarMetodoPagoXCodigo(id).FirstOrDefault();

            if (metodo == null)
            {
                return HttpNotFound();
            }
            return View(metodo);
        }

        // POST: MetodoPago/Enable/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.SP_HabilitarMetodoPago(id);
            return RedirectToAction("Index");
        }
    }
}
