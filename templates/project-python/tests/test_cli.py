from mon_projet.cli import greet, main


def test_greet():
    assert greet("Ada") == "Bonjour, Ada !"


def test_main_retourne_zero(capsys):
    assert main(["Ada"]) == 0
    assert "Ada" in capsys.readouterr().out


def test_main_sans_argument(capsys):
    assert main([]) == 0
    assert "monde" in capsys.readouterr().out
