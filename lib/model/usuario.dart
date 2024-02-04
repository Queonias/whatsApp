class Usuario {
  late String nome;
  late String _email;
  late String _senha;

  get email => _email;

  set email(value) => _email = value;

  get senha => _senha;

  set senha(value) => _senha = value;
}
