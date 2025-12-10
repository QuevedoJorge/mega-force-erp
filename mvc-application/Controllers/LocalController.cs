using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using pe.com.megaforce;

namespace pe.com.megaforce.Controllers
{
    public class LocalController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Local
        public ActionResult Index()
        {
            //return View(db.Locales.ToList());
            var lista = db.Database.SqlQuery<Locales>("SP_MostrarLocalesTodo").ToList();
            return View(lista);
        }

        // GET: Local/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //Locales locales = db.Locales.Find(id);
            //if (locales == null)
            SqlParameter pid = new SqlParameter("@codigo", id);
            var local = db.Database.SqlQuery<Locales>
                ("SP_BuscarLocalesXCodigo @codigo", pid).FirstOrDefault();
            if (local == null)
            {
                return HttpNotFound();
            }
            return View(local);
        }

        // GET: Local/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Local/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoLocal,tipo,direccion,capacidadMaxima,estado")] Locales locales)
        {
            if (ModelState.IsValid)
            {
                //db.Locales.Add(locales);
                //db.SaveChanges();
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarLocales @nombre, @direccion, @capacidadMaxima, @estado",
                    new SqlParameter("@nombre", locales.tipo),
                    new SqlParameter("@direccion", locales.direccion),
                    new SqlParameter("@capacidadMaxima", locales.capacidadMaxima),
                    new SqlParameter("@estado", locales.estado)
                    );
                return RedirectToAction("Index");
            }

            return View(locales);
        }

        // GET: Local/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //Locales locales = db.Locales.Find(id);
            SqlParameter pid = new SqlParameter("@codigo", id);
            var local = db.Database.SqlQuery<Locales>
                ("SP_BuscarLocalesXCodigo @codigo", pid).FirstOrDefault();
            if (local == null)
            {
                return HttpNotFound();
            }
            return View(local);
        }

        // POST: Local/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoLocal,tipo,direccion,capacidadMaxima,estado")] Locales locales)
        {
            if (ModelState.IsValid)
            {
                //db.Entry(locales).State = EntityState.Modified;
                //db.SaveChanges();
                db.Database.ExecuteSqlCommand(
                "SP_ActualizarLocales @codigoLocal, @tipo, @direccion, @capacidadMaxima, @estado",
                    new SqlParameter("@codigoLocal", locales.codigoLocal),
                    new SqlParameter("@tipo", locales.tipo),
                    new SqlParameter("@direccion", locales.direccion),
                    new SqlParameter("@capacidadMaxima", locales.capacidadMaxima),
                    new SqlParameter("@estado", locales.estado)
                    );
                return RedirectToAction("Index");
            }
            return View(locales);
        }

        // GET: Local/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //Locales locales = db.Locales.Find(id);
            SqlParameter pid = new SqlParameter("@codigo", id);
            var local = db.Database.SqlQuery<Locales>
                ("SP_BuscarLocalesXCodigo @codigo", pid).FirstOrDefault();
            if (local == null)
            {
                return HttpNotFound();
            }
            return View(local);
        }

        // POST: Local/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            //Locales locales = db.Locales.Find(id);
            //db.Locales.Remove(locales);
            //db.SaveChanges();
            db.Database.ExecuteSqlCommand(
                "SP_EliminarLocales @codigo",
                new SqlParameter("@codigo", id)
                );
            return RedirectToAction("Index");
        }

        // GET: Local/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //Locales locales = db.Locales.Find(id);
            SqlParameter pid = new SqlParameter("@codigo", id);
            var local = db.Database.SqlQuery<Locales>
                ("SP_BuscarLocalesXCodigo @codigo", pid).FirstOrDefault();
            if (local == null)
            {
                return HttpNotFound();
            }
            return View(local);
        }

        // POST: Local/Delete/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            //Locales locales = db.Locales.Find(id);
            //db.Locales.Remove(locales);
            //db.SaveChanges();
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarLocales @codigo",
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
