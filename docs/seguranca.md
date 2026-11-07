# Segurança: o que entra na versão final

A plataforma guarda nome e telefone de pessoas reais e mexe com um ranking que precisa ser confiável. Estes itens fazem parte do sistema desde o início, não são acabamento.
O protótipo simula só a tela de entrada (senha e código fixos, bloqueio por tentativas, sessão de 30 minutos, perfis e auditoria).

## Acesso ao painel

- Não existe cadastro aberto. Só entra quem um administrador criou em Usuários.
- Senha guardada com Argon2id.
- Segunda etapa obrigatória com aplicativo autenticador (TOTP), para todos os usuários.
- Bloqueio crescente depois de tentativas erradas. A mensagem de erro não revela se o e-mail existe.
- Sessão em cookie HttpOnly, Secure e SameSite, que expira após 30 minutos sem uso.
- Perfis administrador, organizador e leitura, com a permissão conferida no servidor a cada ação.

### Cadastro do autenticador no primeiro acesso

1. O sistema gera um segredo só daquele usuário e mostra na tela como QR code.
2. O usuário abre o Google Authenticator, o Microsoft Authenticator ou o Authy e escaneia.
3. O aplicativo passa a mostrar um código de 6 dígitos que muda a cada 30 segundos.
4. Ele digita o código uma vez para confirmar. A partir daí todo acesso pede senha e o código do momento.

Junto com isso:
- Dez códigos de reserva de uso único, entregues no cadastro, para troca ou perda do celular.
- Botão em Usuários para o administrador zerar o autenticador de alguém. O usuário cadastra de novo no acesso seguinte.
- O segredo fica cifrado no banco. Códigos de reserva ficam guardados só como hash.
- Código por e-mail fica, no máximo, como reserva. Não é o método padrão.

## Aplicação

- HTTPS obrigatório, com HSTS.
- Consultas ao banco sempre parametrizadas.
- Entrada validada e saída escapada. Política de segurança de conteúdo (CSP) restritiva.
- Proteção contra CSRF em toda ação que altera dado.
- Limite de requisições por IP e por usuário.
- Dependências com versão fixada e verificação automática de vulnerabilidades.

## Dados

- Banco sem porta aberta para a internet.
- Backup diário cifrado, fora do servidor, com teste de restauração periódico.
- Senhas e chaves em variáveis de ambiente, nunca no código.
- Só o dado necessário: nome, telefone, empresa, cargo e grupo (turma, cidade).
- LGPD: registro da autorização de cada membro, SAIR respeitado na hora, exportação e exclusão pelo painel.
- Telefone mascarado nos registros técnicos.

## Integridade do ranking

- Livro de lançamentos: não há edição de saldo.
- Auditoria de toda entrada e de toda alteração, sem edição.
- QR do check-in muda a cada minuto. Check-in só com a janela aberta e só para convidados.
- Identificador único por mensagem recebida, para não lançar ponto em dobro.

## Servidor

- Firewall só com as portas 80 e 443. Administração por chave SSH.
- Atualizações de segurança automáticas.
- n8n sem acesso pela internet.
- Monitoramento com alerta para queda, pico de tentativas de login e erro de envio.

## Antes de publicar

- Teste de invasão independente.
- Revisão das permissões de cada perfil com um usuário de cada tipo.
