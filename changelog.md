# DCI Standards – Changelog

All notable changes to this project are documented in this file.  
This project follows [semantic versioning](https://semver.org/).

# Release Notes

## [Unreleased] – 2026-10-23

### Decision Summary
- Domain registry APIs (CRVS, DR, ESS, FR, IBR, Social) aligned with the core registry API: message envelope, callback headers, per-endpoint actions and security.
- Every custom sync endpoint has its own `action` / `on-<action>` pair instead of reusing `search` / `on-search`.
- Callback endpoints `on-subscribe` and `on-unsubscribe` use `MsgCallbackHeader_V1.0.0`, like all other callbacks.
- Broken `schema.spdci.org` and `standards.spdci.org` links fixed; Authz API source restored to `src/authz`.

---

### Changes

| Type            | Field / Item                  | Description                   | Ref / Notes |
|---------------  |-------------------------------|------------------------------ |-------------|
| 🔴 **Breaking** | IBR `/registry/sync/enrolled` `header.action` | `search` → `enrolled`; response action `on-enrolled` | Response previously had no header |
| 🔴 **Breaking** | IBR `/registry/sync/enrolled` response | Bare `EnrolledResponse` → `{signature, header, message}` envelope; read the payload from `message` | Same envelope as core `/registry/sync/search` |
| 🔴 **Breaking** | IBR `/registry/sync/enrollment/updates` `header` | `MsgCallbackHeader_V1.0.0` → `MsgHeader_V1.0.0` (`sender_id`, `total_count` now required); action `notify` → `enrollment-updates`; `message` required | |
| 🔴 **Breaking** | IBR `/registry/sync/enrollment/updates` response | Bare `EnrollmentUpdatesResponse` → `{signature, header, message}` envelope with action `on-enrollment-updates` | |
| 🔴 **Breaking** | ESS `/registry/sync/check-enrollment` `header.action` | `enrollementstatus` → `check-enrollment`; response action `txn-on-status` → `on-check-enrollment` | |
| 🔴 **Breaking** | DR `/registry/sync/get-disability-support` `header.action` | `search` / `on-search` → `get-disability-support` / `on-get-disability-support` | |
| 🔴 **Breaking** | DR `/registry/sync/get-disability-details` `header.action` | `search` / `on-search` → `get-disability-details` / `on-get-disability-details` | |
| 🔴 **Breaking** | DR `/registry/sync/disabled` `header.action` | `search` / `on-search` → `disabled` / `on-disabled` | |
| 🔴 **Breaking** | `/registry/on-subscribe`, `/registry/on-unsubscribe` `header` (core, CRVS, DR, ESS, FR, IBR, Social) | `MsgHeader_V1.0.0` → `MsgCallbackHeader_V1.0.0`: `status` now required; `sender_id`, `total_count` optional; `sender_uri` removed | Aligns with `on-search`, `notify`, `txn/on-status` |
| 🔴 **Breaking** | `security: Authorization` on DR custom sync endpoints, FR `sync/txn/status`, IBR `sync/enrolled` and `sync/txn/status`, ESS `sync/check-enrollment` and `sync/txn/status` | Bearer token now required; calls without it get HTTP 401 | Previously unsecured |
| 🔴 **Breaking** | IBR `securitySchemes` | Fixed `securitySchemas` typo; the `Authorization` scheme is now actually defined for all IBR endpoints | |
| 🔴 **Breaking** | Core and DR `SearchResponse` `reg_records` | Single `RegistryRecord` → array of `RegistryRecord`, matching CRVS, ESS, FR, IBR and Social | Notify events keep a single `RegistryRecord` |
| ❌ **Removed**  | `multipart/form-data` on sync endpoints | Removed from IBR `sync/enrolled`, ESS `sync/check-enrollment`, DR `sync/get-disability-support`, `sync/get-disability-details`, `sync/disabled` | Core sync endpoints are JSON only |
| ❌ **Removed**  | ESS `MsgSyncHeader_V1.0.0` | Replaced by `MsgHeader_V1.0.0` on ESS sync endpoints | Same required fields; non-breaking for existing requests |
| 🟢 **Added**    | Authz `/oauth2/client/token` client authentication | Accepts several client authentication methods: HTTP Basic (`client_secret_basic`), body credentials (`client_secret_post`), `private_key_jwt` (RFC 7523), mutual TLS (RFC 8705) and the existing bearer token. Added `ClientBasicAuth` security scheme and `client_assertion_type` / `client_assertion` request fields; only `grant_type` is required | Non-breaking: existing bearer-token clients still valid |
| 🟢 **Added**    | Authz `OAuth2ErrorResponse` | `400` / `401` return RFC 6749 §5.2 errors (`error`, `error_description`, `error_uri`) instead of the generic `HttpErrorResponse` | |
| 🟢 **Added**    | DR `/registry/sync/txn/status` | Sync transaction status endpoint, as in core | |
| 🟢 **Added**    | ESS `/registry/sync/txn/status` | Endpoint was mis-indented under `check-enrollment` and not defined | |
| 🟢 **Added**    | `src/authz/authz_core_api_v1.0.0.yaml` | Authz API source restored (removed in `6408779`) and added back to `build/build_apis.cmd` | Published spec unchanged apart from the client authentication and response changes above |
| 🟡 **Updated**  | Authz `OAuth2ClientTokenResponse.expires_in` | Accepts integer (recommended, RFC 6749 §5.1) or numeric string (backward compatible). Description now says to send the token as `Authorization: Bearer`, not `x-api-token` | Non-breaking |
| 🟡 **Updated**  | IBR process flows 1–2, DR process flows 1–2 sample JSONs | Updated to the new actions, envelopes and header types (`total_count` integer, `meta` object, valid `status`); now validate against the spec | |
| 🟡 **Updated**  | Core `/registry/on-search` | Added `operationId: post_reg_on-search` | |
| 🟡 **Updated**  | Social `/registry/txn/status` response | `default` now returns the standard acknowledgement (`Response`) | |
| 🟡 **Updated**  | ESS response codes | `'200'` → `default`, consistent with other APIs | Documentation only; HTTP status unchanged |
| 🟡 **Updated**  | `schema.spdci.org` links | `@context` links updated to existing `spdci/schemas` paths (`/data/`, `/code/`, `common/v1/api-schemas/`); DR `DisabledPerson` → `PWDPerson`; IBR `GroupTypeEnum` → `core/v1/code/AssistanceUnit` | `extensions/ibr/v1/DisbursementInfo.jsonld` still has no schema |
| 🟡 **Updated**  | `standards.spdci.org` links | Updated to current `/standards/dci-standards/...` pages and section numbers; release links in `release/index.md` point to `spdci.github.io/api-standards` | |
| 🟡 **Updated**  | `build/build_apis.cmd`, `redocly.yaml` | Build now covers CRVS, DR, FR, ESS; `assert/` rule renamed to `rule/` | |

## [1.0.0] – 2025-09-19

### Decision Summary
- 
- 
-

---

### Changes

| Type            | Field / Item                  | Description                   | Ref / Notes |
|---------------  |-------------------------------|------------------------------ |-------------|
|  🟢 **Added**   |-------------------------------|------------------------------ |-------------|
| 🔴 **Breaking** |-------------------------------|------------------------------ |-------------|
| ❌ **Removed**  |-------------------------------|------------------------------ |-------------|
| 🟡 **Updated**  |-------------------------------|------------------------------ |-------------|


