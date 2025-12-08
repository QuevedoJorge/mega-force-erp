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
    public class DetallePedidoController : Controller
    {
        private SmarfitEntities db = new SmarfitEntities();

        // GET: DetallePedido
        public ActionResult Index()
        {
            var lista = db.SP_MostrarDetallePedidoTodo().ToList();
            return View(lista);
        }

        // GET: DetallePedido/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            var detalle = db.SP_BuscarDetallePedidoXCodigo(id).FirstOrDefault();
            if (detalle == null) return HttpNotFound();
            return View(detalle);
        }

        // GET: DetallePedido/Create
        public ActionResult Create()
        {
            var listaPedidos = db.Pedido
                                 .Where(p => p.estado == true)
                                 .Include(p => p.Cliente)
                                 .Select(p => new {
                                     codigoPedido = p.codigoPedido,
                                     TextoMostrar = p.Cliente.nombre + " - Pedido #" + p.codigoPedido
                                 }).ToList();

            ViewBag.codigoPedido = new SelectList(listaPedidos, "codigoPedido", "TextoMostrar");

            var listaEntrenamientos = db.Entrenamiento
                                        .Where(e => e.estado == true)
                                        .Select(e => new {
                                            codigoEntrenamiento = e.codigoEntrenamiento,
                                            tipo = e.tipo
                                        }).ToList();

            ViewBag.codigoEntrenamiento = new SelectList(listaEntrenamientos, "codigoEntrenamiento", "tipo");

            return View();
        }

        // POST: DetallePedido/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoDetallePedido,codigoPedido,codigoEntrenamiento,cantidad,precioUnitario,estado")] DetallePedido detalle)
        {
            if (ModelState.IsValid)
            {
                db.SP_RegistrarDetallePedido(
                    detalle.codigoPedido.ToString(),
                    detalle.codigoEntrenamiento.ToString(),
                    detalle.cantidad.ToString(),
                    detalle.precioUnitario.ToString(),
                    detalle.estado.ToString()
                );
                return RedirectToAction("Index");
            }

            var listaPedidos = db.Pedido.Include(p => p.Cliente)
                                 .Select(p => new {
                                     codigoPedido = p.codigoPedido,
                                     TextoMostrar = p.Cliente.nombre + " (Pedido #" + p.codigoPedido + ")"
                                 }).ToList();

            ViewBag.codigoPedido = new SelectList(listaPedidos, "codigoPedido", "TextoMostrar", detalle.codigoPedido);
            ViewBag.codigoEntrenamiento = new SelectList(db.Entrenamiento, "codigoEntrenamiento", "tipo", detalle.codigoEntrenamiento);
            return View(detalle);
        }

        // GET: DetallePedido/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            var detalle = db.SP_BuscarDetallePedidoXCodigo(id).FirstOrDefault();

            if (detalle == null) return HttpNotFound();

            var listaPedidos = db.Pedido
                                 .Where(p => p.estado == true)
                                 .Include(p => p.Cliente)
                                 .Select(p => new {
                                     codigoPedido = p.codigoPedido,
                                     TextoMostrar = p.Cliente.nombre + " - Pedido #" + p.codigoPedido
                                 }).ToList();

            ViewBag.codigoPedido = new SelectList(listaPedidos, "codigoPedido", "TextoMostrar", detalle.codigoPedido);

            var listaEntrenamientos = db.Entrenamiento
                                        .Where(e => e.estado == true)
                                        .Select(e => new {
                                            codigoEntrenamiento = e.codigoEntrenamiento,
                                            tipo = e.tipo
                                        }).ToList();

            ViewBag.codigoEntrenamiento = new SelectList(listaEntrenamientos, "codigoEntrenamiento", "tipo", detalle.codigoEntrenamiento);

            return View(detalle);
        }

        // POST: DetallePedido/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoDetallePedido,codigoPedido,codigoEntrenamiento,cantidad,precioUnitario,estado")] DetallePedido detalle)
        {
            if (ModelState.IsValid)
            {
                db.SP_ActualizarDetallePedido(
                    detalle.codigoDetallePedido,
                    detalle.codigoPedido.ToString(),
                    detalle.codigoEntrenamiento.ToString(),
                    detalle.cantidad.ToString(),
                    detalle.precioUnitario.ToString(),
                    detalle.estado.ToString()
                );
                return RedirectToAction("Index");
            }

            var listaPedidos = db.Pedido.Include(p => p.Cliente)
                                 .Select(p => new {
                                     codigoPedido = p.codigoPedido,
                                     TextoMostrar = p.Cliente.nombre + " (Pedido #" + p.codigoPedido + ")"
                                 }).ToList();

            ViewBag.codigoPedido = new SelectList(listaPedidos, "codigoPedido", "TextoMostrar", detalle.codigoPedido);
            ViewBag.codigoEntrenamiento = new SelectList(db.Entrenamiento, "codigoEntrenamiento", "tipo", detalle.codigoEntrenamiento);
            return View(detalle);
        }

        // GET: DetallePedido/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            var detalle = db.SP_BuscarDetallePedidoXCodigo(id).FirstOrDefault();
            if (detalle == null) return HttpNotFound();
            return View(detalle);
        }

        // POST: DetallePedido/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.SP_EliminarDetallePedido(id);
            return RedirectToAction("Index");
        }

        // GET: DetallePedido/Enable/5
        public ActionResult Enable(int? id)
        {
            if (id == null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            var detalle = db.SP_BuscarDetallePedidoXCodigo(id).FirstOrDefault();
            if (detalle == null) return HttpNotFound();
            return View(detalle);
        }

        // POST: DetallePedido/Enable/5
        [HttpPost, ActionName("Enable")]
        [ValidateAntiForgeryToken]
        public ActionResult EnableConfirmed(int id)
        {
            db.SP_HabilitarDetallePedido(id);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) db.Dispose();
            base.Dispose(disposing);
        }
    }
}