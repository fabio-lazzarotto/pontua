-- Modelo inicial. Ajustar conforme a stack escolhida.

create extension if not exists pgcrypto;

create table membros (
  id            uuid primary key default gen_random_uuid(),
  nome          text not null,
  telefone      text not null unique,          -- E.164, ex.: 5511999999999
  email         text,
  empresa       text,
  cargo         text,
  tags          text[] not null default '{}',  -- turma, cidade
  optin         boolean not null default false,
  optin_em      timestamptz,
  optin_origem  text,                          -- planilha, formulário, WhatsApp
  observacoes   text,
  criado_em     timestamptz not null default now()
);

create table eventos (
  id              uuid primary key default gen_random_uuid(),
  nome            text not null,
  inicio          timestamptz not null,
  local           text not null,
  descricao       text,
  codigo_checkin  text not null unique,
  checkin_abre    timestamptz,                 -- padrão: inicio - 1h
  checkin_fecha   timestamptz,                 -- padrão: inicio + 2h
  checkin_manual  boolean,                     -- null segue a janela; true/false força
  status          text not null default 'aberto' check (status in ('aberto','encerrado')),
  criado_em       timestamptz not null default now()
);

create table convites (
  id            uuid primary key default gen_random_uuid(),
  evento_id     uuid not null references eventos(id),
  membro_id     uuid not null references membros(id),
  status        text not null default 'pendente'
                check (status in ('pendente','confirmado','recusado','talvez')),
  respondido_em timestamptz,
  checkin_em    timestamptz,
  enviado_em    timestamptz,
  unique (evento_id, membro_id)
);

create table lancamentos (
  id         uuid primary key default gen_random_uuid(),
  membro_id  uuid not null references membros(id),
  evento_id  uuid references eventos(id),
  tipo       text not null check (tipo in ('resposta','checkin','bonus','falta','ajuste')),
  pontos     integer not null,
  descricao  text not null,
  criado_em  timestamptz not null default now()
);
-- No máximo um lançamento automático de cada tipo por membro e evento
create unique index lanc_unico on lancamentos (membro_id, evento_id, tipo) where tipo <> 'ajuste';

create table mensagens (
  id             uuid primary key default gen_random_uuid(),
  membro_id      uuid references membros(id),
  direcao        text not null check (direcao in ('entrada','saida')),
  wa_message_id  text unique,                  -- idempotência de webhook
  tipo           text,                         -- template, texto, botao
  conteudo       jsonb,
  status_envio   text,                         -- enviado, entregue, lido, falhou
  criado_em      timestamptz not null default now()
);

create view ranking as
select m.id, m.nome, m.empresa,
       coalesce(sum(l.pontos), 0) as pontos,
       (select count(*) from convites c where c.membro_id = m.id and c.checkin_em is not null) as presencas
from membros m
left join lancamentos l on l.membro_id = m.id
group by m.id
order by pontos desc, presencas desc, m.nome;
