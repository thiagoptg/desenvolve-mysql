CREATE DATABASE parceiros_db;
USE parceiros_db;
CREATE TABLE partners (
    id VARCHAR(50) PRIMARY KEY,
    trading_name VARCHAR(255) NOT NULL,
    owner_name VARCHAR(255) NOT NULL,
    document VARCHAR(50) NOT NULL UNIQUE,
    coverage_area MULTIPOLYGON NOT NULL SRID 4326,
    address POINT NOT NULL SRID 4326,
    SPATIAL INDEX (coverage_area),
    SPATIAL INDEX (address)
);

SELECT id, trading_name FROM partners;

SELECT 
    id,
    trading_name,
    owner_name,
    document,
    ST_AsGeoJSON(coverage_area) AS coverage_area,
    ST_AsGeoJSON(address) AS address
FROM partners
WHERE id = '1';
SELECT 
    id,
    trading_name,
    owner_name,
    document,
    ST_AsGeoJSON(coverage_area) AS coverage_area,
    ST_AsGeoJSON(address) AS address,
    ST_Distance_Sphere(
        address,
        ST_GeomFromText('POINT(-46.57421 -21.785741)', 4326)
    ) AS distance_in_meters
FROM partners
WHERE ST_Contains(
    coverage_area,
    ST_GeomFromText('POINT(-46.57421 -21.785741)', 4326)
)
ORDER BY distance_in_meters
LIMIT 1;

SET @ponto = ST_GeomFromText('POINT(-46.57421 -21.785741)', 4326);

SELECT 
    id,
    trading_name,
    ST_Distance_Sphere(address, @ponto) AS distance
FROM partners
WHERE ST_Contains(coverage_area, @ponto)
ORDER BY distance
LIMIT 1;







