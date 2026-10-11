"""In-memory synthetic tests only; do not verify encryption or app policy."""
from pathlib import Path
import sqlite3


def check_schema():
    con = sqlite3.connect(":memory:")
    con.executescript(Path(__file__).with_name("logical-schema.sql").read_text())
    checks = []

    def rejected(sql, values, label):
        try:
            con.execute(sql, values)
        except sqlite3.IntegrityError:
            checks.append(label)
        else:
            raise AssertionError(f"Expected rejection: {label}")

    for v in ("v1", "v2"):
        con.execute("INSERT INTO vaults VALUES(?,?,?,?,?)", (v, "owner", 1, 1, "2026-10-02T21:00:00Z"))
    con.execute("INSERT INTO captures(vault_id,id,kind,received_at,source_hash) VALUES(?,?,?,?,?)", ("v1", "cap1", "image", "t", "hash1"))
    con.execute("INSERT INTO captures(vault_id,id,kind,received_at,source_hash) VALUES(?,?,?,?,?)", ("v2", "cap2", "image", "t", "hash2"))
    assert con.execute("SELECT privacy,review_state FROM captures WHERE vault_id='v1'").fetchone() == ("private", "unreviewed")
    checks.append("private unreviewed defaults")
    rejected("INSERT INTO captures(vault_id,id,kind,received_at,source_hash) VALUES(?,?,?,?,?)", ("v1", "dup", "image", "t", "hash1"), "exact-source dedupe")
    con.execute("INSERT INTO observations VALUES(?,?,?,?,?,?)", ("v1", "obs1", "cap1", "Sky Archive", "synthetic", 1))
    con.execute("INSERT INTO entities(vault_id,id,name,type) VALUES(?,?,?,?)", ("v1", "ent1", "Sky Archive", "book"))
    rejected("INSERT INTO mentions(vault_id,id,entity_id,capture_id,observation_id,start_offset,end_offset) VALUES(?,?,?,?,?,?,?)", ("v2", "m2", "ent1", "cap2", "obs1", 0, 3), "cross-vault reference")
    rejected("INSERT INTO mentions(vault_id,id,entity_id,capture_id,observation_id,start_offset,end_offset) VALUES(?,?,?,?,?,?,?)", ("v1", "bad", "ent1", "missing", "obs1", 0, 3), "evidence capture mismatch")
    rejected("INSERT INTO mentions(vault_id,id,entity_id,capture_id,observation_id,start_offset,end_offset) VALUES(?,?,?,?,?,?,?)", ("v1", "bad2", "ent1", "cap1", "obs1", 3, 2), "reversed evidence offsets")
    con.execute("INSERT INTO mentions(vault_id,id,entity_id,capture_id,observation_id,start_offset,end_offset) VALUES(?,?,?,?,?,?,?)", ("v1", "m1", "ent1", "cap1", "obs1", 0, 3))
    rejected("INSERT INTO actions(vault_id,id,title,reminder_consent) VALUES(?,?,?,?)", ("v1", "a1", "Review", 1), "unconfirmed reminder")
    rejected("INSERT INTO actions(vault_id,id,title,date_confirmed) VALUES(?,?,?,?)", ("v1", "a2", "Review", 1), "confirmed date lacks datetime/timezone")
    con.execute("INSERT INTO search_documents(vault_id,capture_id,title,body) VALUES(?,?,?,?)", ("v1", "cap1", "Sky Archive", "reading"))
    assert con.execute("SELECT count(*) FROM search_fts WHERE search_fts MATCH 'Sky'").fetchone()[0] == 1
    con.execute("UPDATE search_documents SET title='River Pilgrim' WHERE capture_id='cap1'")
    assert con.execute("SELECT count(*) FROM search_fts WHERE search_fts MATCH 'Sky'").fetchone()[0] == 0
    assert con.execute("SELECT count(*) FROM search_fts WHERE search_fts MATCH 'River'").fetchone()[0] == 1
    checks.append("FTS edit consistency")
    con.execute("DELETE FROM captures WHERE vault_id='v1' AND id='cap1'")
    assert con.execute("SELECT count(*) FROM mentions").fetchone()[0] == 0
    assert con.execute("SELECT count(*) FROM observations").fetchone()[0] == 0
    assert con.execute("SELECT count(*) FROM entities").fetchone()[0] == 1
    assert con.execute("SELECT count(*) FROM search_fts WHERE search_fts MATCH 'River'").fetchone()[0] == 0
    assert not con.execute("PRAGMA foreign_key_check").fetchall()
    checks.append("source-delete cascade retains entity and clears FTS")
    con.close()
    return checks


if __name__ == "__main__":
    for result in check_schema():
        print("PASS", result)
