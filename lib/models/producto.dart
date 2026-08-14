class Producto {
  final String nombre;
  final double precio;
  final String descripcion;
  final String imagen;
  final String categoria;

  const Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.imagen,
    required this.categoria,
  });
}

final List<Producto> productosDemo = [
  Producto(
    nombre: 'Computadora portatil',
    precio: 45999.99,
    descripcion:
        'Laptop de alto rendimiento ideal para trabajo y estudio, con procesador rapido y buena autonomia de bateria.',
    imagen: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    categoria: 'Tecnologia',
  ),
  Producto(
    nombre: 'Telefono movil',
    precio: 18500.00,
    descripcion:
        'Smartphone con camara de alta resolucion, pantalla AMOLED y gran capacidad de almacenamiento.',
    imagen: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    categoria: 'Tecnologia',
  ),
  Producto(
    nombre: 'Audifonos',
    precio: 2450.50,
    descripcion: 'Audifonos inalambricos con cancelacion de ruido y sonido de alta fidelidad.',
    imagen: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    categoria: 'Accesorios',
  ),
  Producto(
    nombre: 'Teclado',
    precio: 1899.00,
    descripcion: 'Teclado mecanico retroiluminado, comodo para trabajo prolongado y videojuegos.',
    imagen: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400',
    categoria: 'Accesorios',
  ),
  Producto(
    nombre: 'Reloj inteligente',
    precio: 6750.00,
    descripcion:
        'Smartwatch con monitor de ritmo cardiaco, GPS integrado y resistencia al agua.',
    imagen: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    categoria: 'Wearables',
  ),
];
