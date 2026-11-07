# Arquitetura proposta

    Painel (admin)  ->  Backend (API)  ->  PostgreSQL
                            |
                            v
                          n8n  <->  WhatsApp Business API  <->  Membros

## Componentes

Painel web: telas do protótipo (Ranking, Eventos, Membros, Regras). Fala só com o backend.

Backend: regras de negócio, autenticação do administrador, escrita no banco. Expõe endpoints para o painel e para o n8n.
Toda regra de pontos mora aqui, não no n8n.

n8n: orquestração.
- Disparo de convites e lembretes (recebe a lista do backend e chama a API do WhatsApp).
- Recebe o webhook do WhatsApp e repassa para o backend.
- Agendamentos: lembrete 24h antes, abrir e fechar check-in.

PostgreSQL: fonte oficial. Ver db/schema.sql.

## Fluxo de resposta ao convite

1. Membro toca em Vou.
2. WhatsApp envia webhook para o n8n.
3. n8n chama o backend (POST /webhooks/whatsapp) com telefone, tipo de mensagem e payload do botão.
4. Backend identifica membro e evento pelo payload do botão, atualiza o convite, lança pontos.
5. Backend devolve o texto de resposta; n8n envia ao membro.

O payload do botão deve carregar o id do convite (ex.: "inv:<uuid>:confirmado") para não depender de adivinhar o evento.

## Idempotência

O WhatsApp pode reenviar webhooks. Guardar o id da mensagem recebida (wa_message_id) com restrição de unicidade e ignorar repetidos.
