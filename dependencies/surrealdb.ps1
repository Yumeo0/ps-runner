param (
    [string]$container_name,
    [string]$user,
    [string]$password,
    [string]$db
)

# Get all running containers with port 5432 exposed
$containers = docker ps --filter "expose=8000" --format "{{.ID}}"

# Stop each container
foreach ($container in $containers) {
    docker stop $container
}

# Check if the container exists
$containerExists = docker ps -a --format "{{.Names}}" | Select-String -Pattern "^$container_name$"
if ($containerExists) {
    Write-Host "Container '$container_name' already exists." -ForegroundColor Green
    docker start $container_name
    Write-Host "Container '$container_name' started." -ForegroundColor Green
} else {
    Write-Host "Creating new container: $container_name" -ForegroundColor Green
    docker run -d --name $container_name `
        -e SURREALDB_ROOT_PASSWORD=$password `
        -p 8000:8000 `
        -u root `
        surrealdb/surrealdb:latest `
        start -u $user -p $password surrealkv://$db
    Write-Host "Container '$container_name' created successfully." -ForegroundColor Green
}
