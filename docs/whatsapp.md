# WhatsApp: pontos de atenção

Itens a validar na documentação oficial da Meta antes de implementar. Políticas e preços mudam.

- Mensagem iniciada pela empresa (convite, lembrete) só sai com modelo (template) aprovado pela Meta. O texto do convite no painel deve virar variáveis de um modelo, não texto livre.
- Dentro da janela de 24h depois de uma mensagem do membro, dá para responder com texto livre. É o caso de PONTOS, RANKING, CHECKIN e AJUDA.
- Botões de resposta rápida no modelo do convite eliminam a necessidade de interpretar texto.
- Opt-in: guardar quando e como o membro autorizou receber mensagens. Respeitar SAIR imediatamente. Vale também para LGPD.
- Qualidade do número: muitos bloqueios ou denúncias derrubam o limite de envio. Mandar só para quem autorizou.
- Custo: mensagens de modelo são cobradas pela Meta. Conferir a tabela atual e definir quem paga.
- Decidir entre Cloud API direto da Meta ou um provedor (BSP).

## Sem a API da Meta (conexão por QR code)

Alternativa para quem não quer passar, ou ainda não passou, pelo cadastro e aprovação na Meta.

O fluxo inteiro funciona pareando um celular da organização por QR code, como no WhatsApp Web, com uma ferramenta de conexão não oficial (por exemplo Evolution API ou Baileys). Convite, resposta, cobrança, lembrete, check-in pelo link do QR e os comandos PONTOS e RANKING continuam valendo. Fica pronto no mesmo dia, sem custo por mensagem e sem aprovação de modelo.

### O que muda

- Resposta por texto: o membro digita VOU, NAO VOU ou TALVEZ (ou 1, 2, 3). Botões de resposta não são confiáveis nesse tipo de conexão. O backend precisa interpretar o texto e saber a qual convite ele se refere.
- Envio em ritmo controlado, com intervalo entre mensagens, e não em lote.
- A sessão cai de tempos em tempos e alguém precisa escanear o QR de novo. O painel precisa mostrar o estado da conexão e avisar quando cair.
- O celular conectado recebe tudo, inclusive grupos e contatos que não são membros. O sistema guarda e mostra só as conversas de membros cadastrados.
- Só entram as conversas a partir da conexão. O histórico antigo do aparelho não é confiável.

### Riscos

- Banimento do número. É uso fora dos termos do WhatsApp. Se acontecer, a organização perde o canal e o histórico com os membros. O risco cresce com número novo, envio em massa e denúncias.
- Exposição das conversas. O serviço que mantém a conexão enxerga tudo o que passa pelo número. Por isso o número tem que ser dedicado, nunca o pessoal do administrador.
- Quebra sem aviso. Quando o WhatsApp muda algo, a ferramenta pode parar até sair correção. Não há suporte nem garantia.
- Imagem. Operar em conexão não oficial pode pesar contra a credibilidade da organização.

### Como reduzir

- Número dedicado, em chip novo, usado normalmente por alguns dias antes do primeiro disparo.
- Enviar só para quem autorizou e pedir que os membros salvem o contato da organização.
- Ritmo de envio controlado.
- E-mail como canal reserva.
- Camada de canal isolada no backend, para trocar a conexão por QR pela API oficial sem refazer o resto.
- Serviço de conexão sem acesso pela internet, no mesmo cuidado do n8n.

### Caminho do meio

Começar pelo QR code para não esperar e abrir o cadastro na Meta em paralelo. Quando sair a aprovação, a troca é feita na camada de canal, sem mexer no resto.

A validar antes de implementar: o prazo real do cadastro na Meta e qual ferramenta de conexão usar.
