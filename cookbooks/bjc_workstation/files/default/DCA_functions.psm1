function Update-RunLists {
    param (
        $env,
        $recipe
    )
    Write-Output "Adding the dca_demo::$recipe to nodes in $env"
    foreach( $node in ` knife node list -E $env ` ) {
    knife node run_list add $node "'''recipe[dca_demo::$recipe]'''"
    }
}

function Invoke-ChefClient {
    param($env)

    Write-Output "Running Chef-Client on all nodes in $env"
    knife ssh "chef_environment:$env" 'sudo chef-client'

}

function DCA-Update-Nodes {
  param(
    $env,
    $recipe
  )
  $environment = $env
  if ($env -match "dev"){
    $environment = "development"
  } elseif ($env -match "sta"){
    $environment = "staging"
  } elseif ($env -match "prod"){
    $environment = "production"
  }

  Write-Output "Updating nodes in $environment with dca_demo::$recipe."
  foreach( $node in ` knife node list -E $environment ` ) {
    knife node run_list add $node "'''recipe[dca_demo::$recipe]'''"
  }
  Write-Output "Converging nodes in the $environment environment"
  knife ssh "chef_environment:$environment" 'sudo chef-client'
}
