using System.Linq;
using System.Web.Http;

namespace rest_application.Controllers
{
    [RoutePrefix("api/pedidoes")]
    public class PedidoesController : ApiController
    {
        // It's better to use dependency injection in a real application,
        // but for this example, a direct instantiation is fine.
        private readonly SmarfitEntities db = new SmarfitEntities();

        // GET: api/pedidoes
        [HttpGet]
        [Route("")]
        public IHttpActionResult FindAll()
        {
            // Using the SP that returns all records, including client info
            var pedidos = db.SP_MostrarPedidoTodo().ToList();
            return Ok(pedidos);
        }

        // GET: api/pedidoes/active
        [HttpGet]
        [Route("active")]
        public IHttpActionResult FindAllActive()
        {
            // Using the SP that returns only active records
            var pedidos = db.SP_MostrarPedido().ToList();
            return Ok(pedidos);
        }

        // GET: api/pedidoes/5
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult FindById(int id)
        {
            // Using the SP to find by ID and returning a single object or null
            var pedido = db.SP_BuscarPedidoXCodigo(id).FirstOrDefault();
            if (pedido == null)
            {
                return NotFound();
            }
            return Ok(pedido);
        }
        
        // POST: api/pedidoes
        [HttpPost]
        [Route("")]
        public IHttpActionResult Add([FromBody] Pedido obj)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            // Calling the registration SP. No SaveChanges() needed.
            db.SP_RegistrarPedido(obj.codigoCliente, obj.total, obj.estado);
            return Ok();
        }

        // PUT: api/pedidoes/5
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult Update(int id, [FromBody] Pedido obj)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            // Ensure the ID from the URL matches the object, a common best practice
            if (id != obj.codigoPedido)
            {
                return BadRequest("ID mismatch");
            }
            // Calling the update SP. No SaveChanges() needed.
            db.SP_ActualizarPedido(obj.codigoPedido, obj.codigoCliente, obj.total, obj.estado);
            return Ok();
        }

        // DELETE: api/pedidoes/5
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            // Calling the logical delete SP. No SaveChanges() needed.
            db.SP_EliminarPedido(id);
            return Ok();
        }

        // GET: api/pedidoes/code
        [HttpGet]
        [Route("code")]
        public IHttpActionResult FindNextCode()
        {
            // Getting the next code and returning the single value
            var siguienteCodigo = db.SP_CodigoPedido().FirstOrDefault();
            return Ok(siguienteCodigo);
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
