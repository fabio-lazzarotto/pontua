# Regras de pontuação

Fonte oficial das regras. Se o código divergir deste arquivo, o arquivo vale.

## Pontos

| Ação | Pontos | Quando é lançado |
|---|---|---|
| Responder o convite (vou, não vou ou talvez) | +5 | Na primeira resposta do membro àquele evento. Mudar de resposta não gera ponto de novo. |
| Check-in no evento | +50 | No check-in válido. |
| Bônus: confirmou e compareceu | +20 | No check-in, se a resposta registrada era Vou. |
| Confirmou e não fez check-in | -20 | Ao encerrar o evento. |

Confirmar sozinho não dá pontos. Motivo: se Vou desse ponto, o membro clicaria só pelo ranking e a lista de presença deixaria de ser confiável.

Quem fez check-in sem ter confirmado ganha só os 50.

## Ranking

Ordem: pontos (maior primeiro), depois número de presenças, depois nome.
O saldo é sempre a soma dos lançamentos. Nunca editar saldo direto. Correção manual entra como lançamento do tipo ajuste, com motivo.

## Comandos no WhatsApp

| Mensagem | Resposta |
|---|---|
| PONTOS | Saldo, posição e os três últimos lançamentos |
| RANKING | Cinco primeiros e a posição do membro, se ele estiver fora do top 5 |
| CHECKIN <codigo> | Registra a presença |
| AJUDA | Lista os comandos |
| SAIR | Para de receber convites |
| VOLTAR | Volta a receber convites |
| SIM, VOU, NAO, TALVEZ (texto) | Responde o convite aberto mais recente |

Comparação sem acento e sem diferença de maiúscula/minúscula.

## Check-in

Cada evento tem um código curto (ex.: SP2011, iniciais do local + dia + mês).
O QR code na entrada aponta para https://wa.me/<numero>?text=CHECKIN%20<codigo>.
Janela padrão: abre 1h antes do início e fecha 2h depois. O administrador pode abrir e fechar manualmente.
Recusar com mensagem clara: código inexistente, check-in fechado, membro não convidado, check-in repetido.
