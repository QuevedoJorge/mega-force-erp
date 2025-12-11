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
    public class TrainerController : Controller
    {
        private megaforceEntities db = new megaforceEntities();

        // GET: Trainer
        public ActionResult Index()
        {
            //return View(db.Trainer.ToList());
            var lista = db.Database.SqlQuery<Trainer>("SP_MostrarTrainerTodo").ToList();
            return View(lista);
        }

        // GET: Trainer/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var trainer = db.Database.SqlQuery<Trainer>
                ("SP_BuscarTrainerXCodigo @codigo", pid).FirstOrDefault();
            if (trainer == null)
            {
                return HttpNotFound();
            }
            return View(trainer);
        }

        // GET: Trainer/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Trainer/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoTrainer,nombre," +
            "apellido,especialidad,disponibilidad,estado")] Trainer trainer)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_RegistrarTrainer @nombre, @apellido, @especialidad, @disponibilidad, @estado",
                    new SqlParameter("@nombre", trainer.nombre),
                    new SqlParameter("@apellido", trainer.apellido),
                    new SqlParameter("@especialidad", trainer.especialidad),
                    new SqlParameter("@disponibilidad", trainer.disponibilidad),
                    new SqlParameter("@estado", trainer.estado)
                    );
                return RedirectToAction("Index");
            }

            return View(trainer);
        }

        // GET: Trainer/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var trainer = db.Database.SqlQuery<Trainer>
                ("SP_BuscarTrainerXCodigo @codigo", pid).FirstOrDefault();
            if (trainer == null)
            {
                return HttpNotFound();
            }
            return View(trainer);
        }

        // POST: Trainer/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoTrainer,nombre,apellido,especialidad,disponibilidad,estado")] Trainer trainer)
        {
            if (ModelState.IsValid)
            {
                db.Database.ExecuteSqlCommand(
                    "SP_ActualizarTrainer @codigoTrainer, @nombre, @apellido, @especialidad, @disponibilidad, @estado",
                    new SqlParameter("@codigoTrainer", trainer.codigoTrainer),
                    new SqlParameter("@nombre", trainer.nombre),
                    new SqlParameter("@apellido", trainer.apellido),
                    new SqlParameter("@especialidad", trainer.especialidad),
                    new SqlParameter("@disponibilidad", trainer.disponibilidad),
                    new SqlParameter("@estado", trainer.estado)
                    );
                return RedirectToAction("Index");
            }
            return View(trainer);
        }

        // GET: Trainer/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var trainer = db.Database.SqlQuery<Trainer>
                ("SP_BuscarTrainerXCodigo @codigo", pid).FirstOrDefault();
            if (trainer == null)
            {
                return HttpNotFound();
            }
            return View(trainer);
        }

        // POST: Trainer/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_EliminarTrainer @codigo",
                new SqlParameter("@codigo", id)
                );
            return RedirectToAction("Index");
        }

        // GET: Trainer/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SqlParameter pid = new SqlParameter("@codigo", id);
            var trainer = db.Database.SqlQuery<Trainer>
                ("SP_BuscarTrainerXCodigo @codigo", pid).FirstOrDefault();
            if (trainer == null)
            {
                return HttpNotFound();
            }
            return View(trainer);
        }

        // POST: Trainer/Enable/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.Database.ExecuteSqlCommand(
                "SP_HabilitarTrainer @codigo",
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
