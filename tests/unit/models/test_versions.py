"""
Contains tests for application utility endpoints (version, health, etc.)
"""

import pytest

@pytest.mark.versions
def test_version_route(client, monkeypatch):
    """
    Docstring for test_version_route
    
    :param client: Description
    :param monkeypatch: Description
    """
    monkeypatch.setenv("MICROBLOG_VERSION", "v9.9.9")
    res = client.get("/version")
    assert res.status_code == 200
    assert res.get_json()["version"] == "v9.9.9"
