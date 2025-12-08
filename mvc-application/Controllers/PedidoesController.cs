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
    public class PedidoesController : Controller
    {
        private SmarfitEntities db = new SmarfitEntities();

        // GET: Pedidoes
        public ActionResult Index()
        {
            // Call the SP to get all orders with client data
            var pedidos = db.SP_MostrarPedidoTodo().ToList();
            return View(pedidos);
        }

        // GET: Pedidoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Call the SP to find an order by ID
            var pedido = db.SP_BuscarPedidoXCodigo(id).FirstOrDefault();
            if (pedido == null)
            {
                return HttpNotFound();
            }
            return View(pedido);
        }

        // GET: Pedidoes/Create
        public ActionResult Create()
        {
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre");
            return View();
        }

        // POST: Pedidoes/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigoCliente,total,estado")] Pedido pedido)
        {
            if (ModelState.IsValid)
            {
                db.SP_RegistrarPedido(
    pedido.codigoCliente.ToString(),
    pedido.idMetodoPago.ToString(),
    pedido.fechaPedido.ToString(),
    "0",
    pedido.estado.ToString()
);
                return RedirectToAction("Index");
            }

            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", pedido.codigoCliente);
            return View(pedido);
        }

        // GET: Pedidoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Find the original order to pre-fill the form
            Pedido pedido = db.Pedido.Find(id);
            if (pedido == null)
            {
                return HttpNotFound();
            }
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", pedido.codigoCliente);
            return View(pedido);
        }

        // POST: Pedidoes/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigoPedido,codigoCliente,fechaPedido,total,estado")] Pedido pedido)
        {
            if (ModelState.IsValid)
            {
                // Call the SP to update the order
                db.SP_ActualizarPedido(
    pedido.codigoPedido,
    pedido.codigoCliente.ToString(),
    pedido.idMetodoPago.ToString(),    
    pedido.fechaPedido.ToString(),    
    "0",                               
    pedido.estado.ToString()          
);
                return RedirectToAction("Index");
            }
            ViewBag.codigoCliente = new SelectList(db.Cliente, "codigoCliente", "nombre", pedido.codigoCliente);
            return View(pedido);
        }

        // GET: Pedidoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            // Call the SP to find the order to be deleted
            var pedido = db.SP_BuscarPedidoXCodigo(id).FirstOrDefault();
            if (pedido == null)
            {
                return HttpNotFound();
            }
            return View(pedido);
        }

        // POST: Pedidoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            // Call the SP to perform a logical delete
            db.SP_EliminarPedido(id);
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
