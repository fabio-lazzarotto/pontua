-- Dados de exemplo, todos fictícios. Carregado automaticamente pelo docker compose depois do schema.sql.
-- Os pontos seguem docs/regras-pontuacao.md: resposta 5, check-in 50, bônus 20, falta -20.

insert into membros (id, nome, telefone, email, empresa, cargo, tags, optin, optin_em, optin_origem) values
  ('00000000-0000-0000-0000-000000000001', 'Ana Ribeiro',      '5511900000001', 'ana@exemplo.com',     'Banco Horizonte',  'Gerente de Projetos',    '{"Turma 2025","São Paulo"}',      true, now() - interval '200 days', 'formulário de inscrição'),
  ('00000000-0000-0000-0000-000000000002', 'Bruno Tavares',    '5511900000002', 'bruno@exemplo.com',   'Grupo Varella',    'Analista de Dados',      '{"Turma 2025","São Paulo"}',      true, now() - interval '190 days', 'planilha'),
  ('00000000-0000-0000-0000-000000000003', 'Carla Menezes',    '5521900000003', 'carla@exemplo.com',   'Saúde Integra',    'Designer de Produto',    '{"Turma 2026","Rio de Janeiro"}', true, now() - interval '120 days', 'WhatsApp, comando VOLTAR'),
  ('00000000-0000-0000-0000-000000000004', 'Diego Albuquerque','5511900000004', null,                  'Logística Atlas',  'Engenharia de Software', '{"Turma 2025","São Paulo"}',      true, now() - interval '150 days', 'planilha'),
  ('00000000-0000-0000-0000-000000000005', 'Eduarda Siqueira', '5519900000005', 'eduarda@exemplo.com', 'Energia Prisma',   'Analista de RH',         '{"Turma 2026","Campinas"}',       true, now() - interval '90 days',  'formulário de inscrição');

insert into eventos (id, nome, inicio, local, descricao, codigo_checkin, checkin_abre, checkin_fecha, status) values
  ('10000000-0000-0000-0000-000000000001', 'Workshop: gestão de projetos ágeis', now() - interval '20 days', 'São Paulo',
   'Oficina prática com casos reais e troca de experiências.', 'SP0001', now() - interval '20 days 1 hour', now() - interval '20 days' + interval '2 hours', 'encerrado'),
  ('10000000-0000-0000-0000-000000000002', 'Encontro de Fim de Ano São Paulo', now() + interval '24 days', 'São Paulo',
   'Encontro de fim de ano com palestra e networking.', 'SP0002', now() + interval '24 days' - interval '1 hour', now() + interval '24 days 2 hours', 'aberto');

-- Evento encerrado: cobre todos os casos das regras
insert into convites (evento_id, membro_id, status, enviado_em, respondido_em, checkin_em) values
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'confirmado', now() - interval '30 days', now() - interval '29 days', now() - interval '20 days'),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'confirmado', now() - interval '30 days', now() - interval '28 days', null),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'talvez',     now() - interval '30 days', now() - interval '27 days', now() - interval '20 days'),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004', 'recusado',   now() - interval '30 days', now() - interval '29 days', null),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000005', 'pendente',   now() - interval '30 days', null, null);

-- Evento futuro: respostas chegando
insert into convites (evento_id, membro_id, status, enviado_em, respondido_em) values
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'confirmado', now() - interval '3 days', now() - interval '2 days'),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'talvez',     now() - interval '3 days', now() - interval '1 day'),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003', 'pendente',   now() - interval '3 days', null),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000004', 'confirmado', now() - interval '3 days', now() - interval '2 days');

insert into lancamentos (membro_id, evento_id, tipo, pontos, descricao) values
  -- Ana: confirmou e foi (5 + 50 + 20)
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'resposta',  5, 'Respondeu o convite'),
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'checkin',  50, 'Check-in no evento'),
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'bonus',    20, 'Bônus: confirmou e compareceu'),
  -- Bruno: confirmou e faltou (5 - 20)
  ('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'resposta',  5, 'Respondeu o convite'),
  ('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'falta',   -20, 'Confirmou e não compareceu'),
  -- Carla: talvez e foi (5 + 50, sem bônus)
  ('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001', 'resposta',  5, 'Respondeu o convite'),
  ('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001', 'checkin',  50, 'Check-in no evento'),
  -- Diego: recusou (5)
  ('00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001', 'resposta',  5, 'Respondeu o convite'),
  -- Respostas do evento futuro
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002', 'resposta',  5, 'Respondeu o convite'),
  ('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', 'resposta',  5, 'Respondeu o convite'),
  ('00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000002', 'resposta',  5, 'Respondeu o convite'),
  -- Correção manual entra como ajuste, nunca editando saldo
  ('00000000-0000-0000-0000-000000000005', null, 'ajuste', 10, 'Ajuste: ajudou na organização do workshop');

-- Resultado esperado em "select * from ranking":
-- Ana 80 (1 presença), Carla 55 (1), Diego 10 (0), Eduarda 10 (0), Bruno -10 (0)
