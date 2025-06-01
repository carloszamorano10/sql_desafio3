--creacion de tablas

-- Tabla Usuarios:

CREATE TABLE usuarios (
    id SERIAL,
    email VARCHAR(50) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30),
    rol VARCHAR(12) NOT NULL CHECK (rol IN ('admin', 'usuario'))
);

-- Tabla Posts:

CREATE TABLE Posts (
    id SERIAL,
    titulo VARCHAR(100) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT
);

-- Tabla Comentarios:

CREATE TABLE Comentarios (
    id SERIAL,
    contenido VARCHAR(500) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id BIGINT,
    post_id BIGINT
);

-- Ingreso de usuarios:

INSERT INTO usuarios (email, nombre, apellido, rol) VALUES 
('carlos@admin.com', 'Carlos', 'Zamorano', 'admin'),
('pedro@usuarios.com', 'Pedro', 'Gonzales', 'usuario'),
('jose@usuarios.com', 'José', 'Navarro', 'usuario'),
('scarlett@usuarios.com', 'Scarlett', 'Fiol', 'usuario'),
('francisca@usuarios.com', 'Francisca', 'Poblete', 'usuario');

-- Ingreso de Posts:

INSERT INTO Posts (titulo, contenido, destacado, usuario_id) VALUES
('prueba 1', 'contenido prueba 1', TRUE, 1),
('prueba 2', 'contenido prueba 2', TRUE, 1),
('ejericios 1', 'contenido ejercicios 1', TRUE, 2),
('ejercicios 2', 'contenido ejercicios 2', FALSE, 2),
('random', 'contenido random', FALSE, null);

-- Ingreso de Comentarios:

INSERT INTO Comentarios (contenido, usuario_id, post_id) VALUES
('comentario 1', 1, 1),
('comentario 2', 2, 1),
('comentario 3', 3, 1),
('comentario 4', 1, 2),
('comentario 5', 2, 2);

-- Requerimiento 2:

SELECT usuarios.nombre AS nombre, usuarios.email AS email, Posts.titulo AS titulo, Posts.contenido AS contenido
FROM usuarios
INNER JOIN Posts ON usuarios.id = Posts.usuario_id;

-- Requerimiento 3:

SELECT Posts.id AS id, Posts.titulo AS titulo, Posts.contenido AS contenido
FROM usuarios
INNER JOIN Posts ON usuarios.id = Posts.usuario_id
WHERE usuarios.rol = 'admin';

-- Requerimiento 4:

SELECT usuarios.id AS id, usuarios.email AS email, COUNT(Posts.usuario_id) AS count
FROM usuarios
LEFT JOIN Posts ON usuarios.id = Posts.usuario_id
GROUP BY usuarios.id, usuarios.email
ORDER BY count;

-- Requerimiento 5:

SELECT usuarios.email AS email
FROM usuarios
LEFT JOIN Posts ON usuarios.id = Posts.usuario_id
GROUP BY usuarios.id, usuarios.email
ORDER BY COUNT(Posts.usuario_id) DESC LIMIT 2;

-- Requerimiento 6:

SELECT usuarios.nombre AS nombre, DATE(MAX(Posts.fecha_creacion)) AS max
FROM usuarios
LEFT JOIN Posts ON usuarios.id = Posts.usuario_id
GROUP BY usuarios.nombre LIMIT 2;


-- Requerimiento 7:

SELECT Posts.titulo AS titulo, Posts.contenido AS contenido
FROM Posts
LEFT JOIN Comentarios ON Posts.id = Comentarios.post_id
GROUP BY Posts.titulo, Posts.contenido
ORDER BY COUNT(Comentarios.post_id) DESC LIMIT 1;


-- Requerimiento 8:

SELECT Posts.titulo AS titulo_post, 
Posts.contenido AS contenido_post, 
Comentarios.contenido AS contenido_comentario,
usuarios.email AS email
FROM Comentarios
LEFT JOIN usuarios ON Comentarios.usuario_id = usuarios.id
LEFT JOIN Posts ON Comentarios.post_id = Posts.id
ORDER BY contenido_comentario;


-- Requerimiento 9:

SELECT DISTINCT ON (usuario_id) 
DATE(fecha_creacion) AS fecha_creacion,
contenido,
usuario_id
FROM Comentarios 
JOIN usuarios ON Comentarios.usuario_id = usuarios.id
ORDER BY usuario_id, fecha_creacion DESC;

-- Requerimiento 10:

SELECT usuarios.email
FROM usuarios
LEFT JOIN Comentarios ON usuarios.id = Comentarios.usuario_id
ORDER BY Comentarios.contenido DESC LIMIT 2;