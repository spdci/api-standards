# This file auto generates all yaml files.
# Assumes the command is run from the root folder i.e ./standards
# For each new category, please make sure to add a reference link in this file for easy auto generation of yamls.

# build auth APIs
swagger-cli -f 2 -t yaml bundle ./src/authz/authz_core_api_v1.0.0.yaml -o ./release/yaml/authz_core_api_v1.0.0.yaml
redocly build-docs ./release/yaml/authz_core_api_v1.0.0.yaml  -o ./release/html/authz_core_api_v1.0.0.html

# build APIs
swagger-cli -f 2 -t yaml bundle ./src/registry/registry_core_api_v1.0.0.yaml -o ./release/yaml/registry_core_api_v1.0.0.yaml
redocly build-docs ./release/yaml/registry_core_api_v1.0.0.yaml  -o ./release/html/registry_core_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/ibr_api_v1.0.0.yaml -o ./release/yaml/ibr_api_v1.0.0.yaml
redocly build-docs ./release/yaml/ibr_api_v1.0.0.yaml  -o ./release/html/ibr_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/social_api_v1.0.0.yaml -o ./release/yaml/social_api_v1.0.0.yaml
redocly build-docs ./release/yaml/social_api_v1.0.0.yaml  -o ./release/html/social_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/crvs_api_v1.0.0.yaml -o ./release/yaml/crvs_api_v1.0.0.yaml
redocly build-docs ./release/yaml/crvs_api_v1.0.0.yaml  -o ./release/html/crvs_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/dr_api_v1.0.0.yaml -o ./release/yaml/dr_api_v1.0.0.yaml
redocly build-docs ./release/yaml/dr_api_v1.0.0.yaml  -o ./release/html/dr_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/fr_api_v1.0.0.yaml -o ./release/yaml/fr_api_v1.0.0.yaml
redocly build-docs ./release/yaml/fr_api_v1.0.0.yaml  -o ./release/html/fr_api_v1.0.0.html

swagger-cli -f 2 -t yaml bundle ./src/registry/ess_api_v1.0.0.yaml -o ./release/yaml/ess_api_v1.0.0.yaml
redocly build-docs ./release/yaml/ess_api_v1.0.0.yaml  -o ./release/html/ess_api_v1.0.0.html


# build locations APIs (source not in this repo)
# swagger-cli -f 2 -t yaml bundle ./src/locations/locations_core_api_v1.0.0.yaml -o ./release/yaml/locations_core_api_v1.0.0.yaml
# redocly build-docs ./release/yaml/locations_core_api_v1.0.0.yaml -o ./release/html/locations_core_api_v1.0.0.html

# build jwks APIs (source not in this repo)
# swagger-cli -f 2 -t yaml bundle ./src/jwks/jwks_core_api_v1.0.0.yaml -o ./release/yaml/jwks_core_api_v1.0.0.yaml
# redocly build-docs ./release/yaml/jwks_core_api_v1.0.0.yaml  -o ./release/html/jwks_core_api_v1.0.0.html


# swagger-cli -f 2 -t yaml bundle ./src/mapper/mapper_core_api_v1.0.0.yaml -o ./release/yaml/mapper_core_api_v1.0.0.yaml
# swagger-cli -f 2 -t yaml bundle ./src/disburse/disburse_core_api_v1.0.0.yaml -o ./release/yaml/disburse_core_api_v1.0.0.yaml
# redocly build-docs ./release/yaml/mapper_core_api_v1.0.0.yaml  -o ./release/html/mapper_core_api_v1.0.0.html
# redocly build-docs ./release/yaml/disburse_core_api_v1.0.0.yaml  -o ./release/html/disburse_core_api_v1.0.0.html
