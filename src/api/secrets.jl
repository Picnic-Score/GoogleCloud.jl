"""
Google Secret Manager API
"""
module _secrets

export secrets

using ..api
using ...root

"""
Google Secret Manager API root.

Secret JSON representation: https://cloud.google.com/secret-manager/docs/reference/rest/v1/projects.secrets#Secret
{
  "name": string,
  "replication": {
    object (Replication)
  },
  "createTime": string,
  "labels": {
    string: string,
    ...
  },

  // Union field expiration can be only one of the following:
  "expireTime": string,
  "ttl": string
  // End of list of possible types for union field expiration.
}

"""
secrets = APIRoot(
    "https://secretmanager.googleapis.com/v1/projects/{project}",
    Dict(
        "cloud-platform" => "Full access to all resources and services in the specified Cloud Platform project.",
    );
    Secrets=APIResource("secrets";  # https://cloud.google.com/secret-manager/docs/reference/rest/v1/projects.secrets/
        list=APIMethod(:GET, "", "Lists matching Secrets"),
        get=APIMethod(:GET, "{secret}", "Gets metadata for a given Secret"),
        create=APIMethod(:POST, "", "Creates a new Secret containing no SecretVersions"),
        addVersion=APIMethod(:POST, "{secret}:addVersion", "Creates a new SecretVersion containing secret data and attaches to an existing Secret"),
        delete=APIMethod(:DELETE, "{secret}", "Deletes a Secret"),
    ),
    Versions=APIResource("secrets/{secret}/versions";  # https://cloud.google.com/secret-manager/docs/reference/rest/v1/projects.secrets.versions/
        list=APIMethod(:GET, "", "Lists SecretVersions.  This call does not return secret data"),
        get=APIMethod(:GET, "{version}", "Gets metadata for a SecretVersion."),
        disable=APIMethod(:POST, "{version}:disable", "Disables a SecretVersion."),
        enable=APIMethod(:POST, "{version}:enable", "Enables a SecretVersion."),
        destroy=APIMethod(:POST, "{version}:destroy", "Destroys a SecretVersion."),
        access=APIMethod(:GET, "{version}:access", "Accesses a SecretVersion. This call returns the secret data."),
    ),
)

end
