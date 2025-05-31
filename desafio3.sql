--creacion de tablas

-- Tabla Usuarios:

CREATE TABLE usuarios (
    id SERIAL,
    email VARCHAR(50) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30),
    rol VARCHAR(12) NOT NULL CHECK (rol IN ('administrador', 'usuario'))
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
