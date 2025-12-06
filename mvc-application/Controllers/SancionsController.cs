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
            var sancion = db.Sancion.Include(s => s.Cliente);
            return View(sancion.ToList());
        }

        // GET: Sancions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sancion sancion = db.Sancion.Find(id);
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
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigo,fechaInicio,fechaFin,motivo,codigoCliente,estado")] Sancion sancion)
        {
            if (ModelState.IsValid)
            {
                db.Sancion.Add(sancion);
                db.SaveChanges();
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
            Sancion sancion = db.Sancion.Find(id);
            if (sancion == null)
            {
                return HttpNotFound();
            }
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", sancion.codigoCliente);
            return View(sancion);
        }

        // POST: Sancions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo,fechaInicio,fechaFin,motivo,codigoCliente,estado")] Sancion sancion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sancion).State = EntityState.Modified;
                db.SaveChanges();
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
            Sancion sancion = db.Sancion.Find(id);
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
            Sancion sancion = db.Sancion.Find(id);
            db.Sancion.Remove(sancion);
            db.SaveChanges();
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
