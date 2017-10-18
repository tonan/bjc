function Update-RunLists {
    param (
        $env,
        $recipe
    )
    Write-Output "Adding the dca_baseline::$recipe to nodes in $env"
    foreach( $node in ` knife node list -E $env ` ) {
    knife node run_list add $node "'''recipe[dca_baseline::$recipe]'''"
    }
}

function Invoke-ChefClient {
    param($env)

    Write-Output "Running Chef-Client on all nodes in $env"
    knife ssh "chef_environment:$env" 'sudo chef-client'

}
