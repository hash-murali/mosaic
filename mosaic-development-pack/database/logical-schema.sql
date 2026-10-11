-- SYNTHETIC LOGICAL SKETCH ONLY. Not an encrypted production migration.
PRAGMA foreign_keys = ON;
CREATE TABLE vaults (
  id TEXT PRIMARY KEY, owner_principal_id TEXT NOT NULL,
  schema_version INTEGER NOT NULL CHECK(schema_version > 0),
  key_version INTEGER NOT NULL CHECK(key_version > 0), created_at TEXT NOT NULL
);
CREATE TABLE captures (
  vault_id TEXT NOT NULL, id TEXT NOT NULL,
  kind TEXT NOT NULL CHECK(kind IN ('image','text','url')),
  received_at TEXT NOT NULL, source_hash TEXT NOT NULL,
  privacy TEXT NOT NULL DEFAULT 'private' CHECK(privacy IN ('private','sensitive','restricted')),
  category TEXT NOT NULL DEFAULT 'other' CHECK(category IN ('entertainment','reading','college','immigration','technology','other')),
  title TEXT NOT NULL DEFAULT '',
  review_state TEXT NOT NULL DEFAULT 'unreviewed' CHECK(review_state IN ('unreviewed','reviewed','archived')),
  revision INTEGER NOT NULL DEFAULT 1 CHECK(revision > 0),
  PRIMARY KEY(vault_id,id), UNIQUE(vault_id,source_hash),
  FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE artifacts (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, capture_id TEXT NOT NULL,
  relative_locator TEXT NOT NULL, plaintext_hash TEXT NOT NULL, media_type TEXT NOT NULL,
  byte_count INTEGER NOT NULL CHECK(byte_count >= 0),
  PRIMARY KEY(vault_id,id), UNIQUE(vault_id,relative_locator),
  FOREIGN KEY(vault_id,capture_id) REFERENCES captures(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE observations (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, capture_id TEXT NOT NULL,
  text TEXT NOT NULL, engine_version TEXT NOT NULL,
  revision INTEGER NOT NULL CHECK(revision > 0),
  PRIMARY KEY(vault_id,id), UNIQUE(vault_id,capture_id,id),
  FOREIGN KEY(vault_id,capture_id) REFERENCES captures(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE entities (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, name TEXT NOT NULL, type TEXT NOT NULL,
  revision INTEGER NOT NULL DEFAULT 1 CHECK(revision > 0),
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE mentions (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, entity_id TEXT NOT NULL,
  capture_id TEXT NOT NULL, observation_id TEXT NOT NULL,
  start_offset INTEGER NOT NULL CHECK(start_offset >= 0),
  end_offset INTEGER NOT NULL CHECK(end_offset > start_offset),
  confirmed INTEGER NOT NULL DEFAULT 0 CHECK(confirmed IN (0,1)),
  PRIMARY KEY(vault_id,id),
  FOREIGN KEY(vault_id,entity_id) REFERENCES entities(vault_id,id) ON DELETE CASCADE,
  FOREIGN KEY(vault_id,capture_id,observation_id) REFERENCES observations(vault_id,capture_id,id) ON DELETE CASCADE
);
CREATE TABLE claims (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, capture_id TEXT NOT NULL, observation_id TEXT NOT NULL,
  statement TEXT NOT NULL,
  start_offset INTEGER NOT NULL CHECK(start_offset >= 0),
  end_offset INTEGER NOT NULL CHECK(end_offset > start_offset),
  verification TEXT NOT NULL DEFAULT 'unverified' CHECK(verification IN ('unverified','owner_checked','externally_verified','disputed','outdated')),
  effective_date_expression TEXT,
  PRIMARY KEY(vault_id,id),
  FOREIGN KEY(vault_id,capture_id,observation_id) REFERENCES observations(vault_id,capture_id,id) ON DELETE CASCADE
);
CREATE TABLE actions (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, claim_id TEXT, title TEXT NOT NULL,
  date_expression TEXT, confirmed_datetime TEXT, timezone TEXT,
  date_confirmed INTEGER NOT NULL DEFAULT 0 CHECK(date_confirmed IN (0,1)),
  reminder_consent INTEGER NOT NULL DEFAULT 0 CHECK(reminder_consent IN (0,1)),
  status TEXT NOT NULL DEFAULT 'suggested' CHECK(status IN ('suggested','adopted','done','dismissed')),
  CHECK(date_confirmed=0 OR (confirmed_datetime IS NOT NULL AND timezone IS NOT NULL)),
  CHECK(reminder_consent=0 OR date_confirmed=1),
  PRIMARY KEY(vault_id,id),
  FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE,
  FOREIGN KEY(vault_id,claim_id) REFERENCES claims(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE jobs (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, capture_id TEXT NOT NULL,
  idempotency_token TEXT NOT NULL, operation TEXT NOT NULL, stage TEXT NOT NULL,
  state TEXT NOT NULL CHECK(state IN ('queued','running','paused','failed','complete')),
  retries INTEGER NOT NULL DEFAULT 0 CHECK(retries >= 0), checkpoint_json TEXT NOT NULL DEFAULT '{}',
  PRIMARY KEY(vault_id,id), UNIQUE(vault_id,idempotency_token),
  FOREIGN KEY(vault_id,capture_id) REFERENCES captures(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE user_states (
  vault_id TEXT NOT NULL, entity_id TEXT NOT NULL,
  status TEXT NOT NULL CHECK(status IN ('discovered','interested','queued','in_progress','paused','completed','dropped')),
  notes TEXT NOT NULL DEFAULT '', revision INTEGER NOT NULL DEFAULT 1 CHECK(revision > 0),
  PRIMARY KEY(vault_id,entity_id),
  FOREIGN KEY(vault_id,entity_id) REFERENCES entities(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE collections (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, label TEXT NOT NULL,
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE collection_entities (
  vault_id TEXT NOT NULL, collection_id TEXT NOT NULL, entity_id TEXT NOT NULL,
  PRIMARY KEY(vault_id,collection_id,entity_id),
  FOREIGN KEY(vault_id,collection_id) REFERENCES collections(vault_id,id) ON DELETE CASCADE,
  FOREIGN KEY(vault_id,entity_id) REFERENCES entities(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE relationships (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, from_entity_id TEXT NOT NULL, to_entity_id TEXT NOT NULL,
  type TEXT NOT NULL, origin TEXT NOT NULL CHECK(origin IN ('explicit','inferred','owner')),
  evidence_json TEXT NOT NULL, confirmed INTEGER NOT NULL DEFAULT 0 CHECK(confirmed IN (0,1)),
  PRIMARY KEY(vault_id,id),
  FOREIGN KEY(vault_id,from_entity_id) REFERENCES entities(vault_id,id) ON DELETE CASCADE,
  FOREIGN KEY(vault_id,to_entity_id) REFERENCES entities(vault_id,id) ON DELETE CASCADE
);
CREATE TABLE corrections (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, target_type TEXT NOT NULL, target_id TEXT NOT NULL,
  field_path TEXT NOT NULL, actor_id TEXT NOT NULL, created_at TEXT NOT NULL,
  before_json TEXT NOT NULL, after_json TEXT NOT NULL, supersedes_id TEXT,
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE,
  FOREIGN KEY(vault_id,supersedes_id) REFERENCES corrections(vault_id,id)
);
CREATE TABLE insights (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, kind TEXT NOT NULL,
  derivation_version TEXT NOT NULL, evidence_json TEXT NOT NULL,
  disposition TEXT NOT NULL CHECK(disposition IN ('active','snoozed','dismissed')),
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE grants (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, principal_id TEXT NOT NULL,
  operations_json TEXT NOT NULL, scope_json TEXT NOT NULL,
  purpose TEXT NOT NULL, destination TEXT NOT NULL, expires_at TEXT NOT NULL,
  revoked INTEGER NOT NULL DEFAULT 0 CHECK(revoked IN (0,1)),
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE audit_events (
  vault_id TEXT NOT NULL, id TEXT NOT NULL, actor_id TEXT NOT NULL, operation TEXT NOT NULL,
  decision TEXT NOT NULL CHECK(decision IN ('allowed','denied','failed')),
  record_ids_json TEXT NOT NULL DEFAULT '[]', occurred_at TEXT NOT NULL,
  PRIMARY KEY(vault_id,id), FOREIGN KEY(vault_id) REFERENCES vaults(id) ON DELETE CASCADE
);
CREATE TABLE search_documents (
  rowid INTEGER PRIMARY KEY, vault_id TEXT NOT NULL, capture_id TEXT NOT NULL,
  title TEXT NOT NULL, body TEXT NOT NULL,
  UNIQUE(vault_id,capture_id),
  FOREIGN KEY(vault_id,capture_id) REFERENCES captures(vault_id,id) ON DELETE CASCADE
);
CREATE VIRTUAL TABLE search_fts USING fts5(title,body,content='search_documents',content_rowid='rowid');
CREATE TRIGGER search_insert AFTER INSERT ON search_documents BEGIN
  INSERT INTO search_fts(rowid,title,body) VALUES(new.rowid,new.title,new.body);
END;
CREATE TRIGGER search_delete AFTER DELETE ON search_documents BEGIN
  INSERT INTO search_fts(search_fts,rowid,title,body) VALUES('delete',old.rowid,old.title,old.body);
END;
CREATE TRIGGER search_update AFTER UPDATE ON search_documents BEGIN
  INSERT INTO search_fts(search_fts,rowid,title,body) VALUES('delete',old.rowid,old.title,old.body);
  INSERT INTO search_fts(rowid,title,body) VALUES(new.rowid,new.title,new.body);
END;
CREATE INDEX mentions_entity_idx ON mentions(vault_id,entity_id);
CREATE INDEX jobs_state_idx ON jobs(vault_id,state);
CREATE INDEX captures_review_idx ON captures(vault_id,review_state,received_at);
CREATE INDEX claims_capture_idx ON claims(vault_id,capture_id);
