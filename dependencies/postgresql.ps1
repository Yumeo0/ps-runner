param (
    [string]$container_name,
    [string]$user,
    [string]$password,
    [string]$db
)

# Get all running containers with port 5432 exposed
$containers = docker ps --filter "expose=5432" --format "{{.ID}}"

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
    Write-Host "Creating new container: $container_name" -ForegroundColor Yellow
    docker run -d --name $container_name `
        -e POSTGRES_USER=$user `
        -e POSTGRES_PASSWORD=$password `
        -e POSTGRES_DB=$db `
        -e POSTGRES_HOST_AUTH_METHOD=trust `
        -p 5432:5432 `
        postgres:latest
    Write-Host "Container '$container_name' created successfully." -ForegroundColor Green
}
