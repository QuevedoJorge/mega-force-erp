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
    public class SancionsController : Controller
    {
        private SmarfitEntities db = new SmarfitEntities();

        // GET: Sancions
        public ActionResult Index()
        {
            // Call the SP to get all sanctions with client data
            var sancion = db.SP_MostrarSancionTodo().ToList();
            return View(sancion);
        }

        // GET: Sancions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Call the SP to find a sanction by ID
            var sancion = db.SP_BuscarSancionXCodigo(id).FirstOrDefault();
            if (sancion == null)
            {
                return HttpNotFound();
            }
            return View(sancion);
        }

        // GET: Sancions/Create
        public ActionResult Create()
        {
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre");
            return View();
        }

        // POST: Sancions/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "fechaInicio,fechaFin,motivo,codigoCliente,estado")] Sancion sancion)
        {
            if (ModelState.IsValid)
            {
                // Call the SP to register the new sanction
                db.SP_RegistrarSancion(
    sancion.fechaInicio.ToString(),
    sancion.fechaFin.ToString(),
    sancion.motivo,
    sancion.codigoCliente.ToString(),
    sancion.estado.ToString()
);
                return RedirectToAction("Index");
            }

            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", sancion.codigoCliente);
            return View(sancion);
        }

        // GET: Sancions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Find the original sanction to pre-fill the form
            Sancion sancion = db.Sancion.Find(id);
            if (sancion == null)
            {
                return HttpNotFound();
            }
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", sancion.codigoCliente);
            return View(sancion);
        }

        // POST: Sancions/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo,fechaInicio,fechaFin,motivo,codigoCliente,estado")] Sancion sancion)
        {
            if (ModelState.IsValid)
            {
                // Call the SP to update the sanction
                db.SP_RegistrarSancion(
    sancion.fechaInicio.ToString(),
    sancion.fechaFin.ToString(),
    sancion.motivo,
    sancion.codigoCliente.ToString(),
    sancion.estado.ToString()
);
                return RedirectToAction("Index");
            }
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", sancion.codigoCliente);
            return View(sancion);
        }

        // GET: Sancions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Call the SP to find the sanction to be deleted
            var sancion = db.SP_BuscarSancionXCodigo(id).FirstOrDefault();
            if (sancion == null)
            {
                return HttpNotFound();
            }
            return View(sancion);
        }

        // POST: Sancions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            // Call the SP to perform a logical delete
            db.SP_EliminarSancion(id);
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
