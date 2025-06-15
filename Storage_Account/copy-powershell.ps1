# Variables
$src_account = "mydatastore96"
$src_container = "sources"
$src_key = "yz64kBEBgDvh75bvEIa4FCvrLpOgrTiLr4YearTyJCqPCEiJyl8+XVjf1URneWX5z9cvYvdZCpie+ASt3L1IdA=="

$dst_account = "mydatastore96"
$dst_container = "destination"
# $dst_key = "yz64kBEBgDvh75bvEIa4FCvrLpOgrTiLr4YearTyJCqPCEiJyl8+XVjf1URneWX5z9cvYvdZCpie+ASt3L1IdA=="

# Get blobs
$blobs = az storage blob list `
  --account-name $src_account `
  --account-key $src_key `
  --container-name $src_container `
  --query "[].name" -o tsv

foreach ($blob in $blobs) {
  Write-Host "Copying: $blob"
  $src_url = "https://$src_account.blob.core.windows.net/$src_container/$blob"

  az storage blob copy start `
    --account-name $dst_account `
    --account-key $dst_key `
    --destination-container $dst_container `
    --destination-blob $blob `
    --source-uri $src_url
}