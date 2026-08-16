# Nelson Neto

**Desenvolvedor full-stack.** Node.js, Express, Prisma e PostgreSQL no back-end; Flutter e JavaScript no front.

Procurando a **primeira oportunidade como Engenheiro de Software Júnior** — aberto a remoto, híbrido ou presencial.
Santa Maria, RS · [mkbraion@gmail.com](mailto:mkbraion@gmail.com) · [Portfólio](https://mkbraion.github.io) · [LinkedIn](https://www.linkedin.com/in/SEU-USUARIO-AQUI)

---

## Projetos

Todos com código aberto e a maioria rodando ao vivo. Comecei escrevendo software para resolver
problemas reais de negócio — controle de estoque, funil de vendas, agenda de visitas — e fui
aprendendo back-end pela necessidade de fazer aquilo funcionar em vários aparelhos com segurança.

### Loja Virtual — autenticação e checkout
Loja full-stack com cadastro, login e checkout. Foi onde estudei segurança de aplicação a sério.

- **O problema que resolve:** o erro clássico da loja mal feita é confiar no preço que o navegador manda. Aqui o carrinho envia só produto e quantidade — **o total é somado a partir do preço do banco**, então não dá para adulterar pelo DevTools.
- Senhas em **bcrypt** (cost 12), **JWT** com segredo em variável de ambiente e expiração, **rate limit** no login, mensagens de erro genéricas (não revelam se o e-mail existe), **Helmet** com CSP, e Prisma com consultas parametrizadas.
- O servidor **se recusa a subir** se o `JWT_SECRET` for fraco ou ausente.
- `Node · Express · Prisma · SQLite/Postgres · JWT · Stripe`

[Código](https://github.com/mkbraion/loja-checkout) · [Como rodar](https://github.com/mkbraion/loja-checkout#como-rodar)

### CRM de Funil de Vendas + API
Um CRM em kanban que funciona offline no navegador e, ao fazer login, sincroniza na nuvem.

- Arquitetura em duas partes: o **front** roda sozinho com `localStorage`; a **API** entra quando o usuário quer os leads em vários aparelhos. Se o servidor cair ou a sessão expirar, volta ao modo local **sem perder dado**.
- Cada lead é isolado por usuário — as rotas checam o dono, protegendo contra **IDOR**.
- REST com sete endpoints, autenticação por Bearer token, deploy automatizado via `render.yaml`.
- `Node · Express · Prisma · PostgreSQL · JWT · JS puro`

[API](https://github.com/mkbraion/crm-api) · [Front](https://github.com/mkbraion/crm-funil-vendas) · [Demo ao vivo](https://mkbraion.github.io/crm-funil-vendas/)

### KAIA Agenda
Agenda de visitas para uma equipe de corretores, em produção.

- Aqui não existe servidor próprio: o navegador fala direto com o Postgres do Supabase. Isso obriga a colocar **toda a autorização no banco**, via **Row Level Security** — porque o JavaScript o usuário consegue alterar.
- Modelo de permissão por cargo, com **trigger que impede o usuário de alterar o próprio cargo** (sem isso, um `UPDATE` na API viraria escalada para admin).
- Script do CDN travado por **Subresource Integrity** e versão fixa, mais **Content-Security-Policy** e HSTS.
- `PostgreSQL · Supabase · RLS · JS puro`

[Código](https://github.com/mkbraion/kaia-agenda) · [Demo ao vivo](https://mkbraion.github.io/kaia-agenda/) · [Modelo de segurança](https://github.com/mkbraion/kaia-agenda/blob/main/SECURITY.md)

### KAIA Lucro
App de gestão para revendedor: lucro real por venda, estoque, fiado e caixa. Instalável (PWA).

- Cada revendedor só enxerga os próprios dados, garantido por RLS no Postgres.
- A loja pública mostra os produtos ao cliente sem vazar **preço de custo e fornecedor** — resolvido com privilégio por coluna no banco, não escondendo campo na tela.
- `Flutter · Dart · Supabase · PostgreSQL`

[App instalável](https://mkbraion.github.io/kaia-lucro-web/)

---

## Tecnologias

**Back-end** — Node.js, Express, Prisma, PostgreSQL, SQLite, REST, JWT, bcrypt
**Front-end** — JavaScript, HTML, CSS, React, Next.js
**Mobile** — Flutter, Dart
**Infra** — Git, GitHub Actions, Render, Vercel, Supabase

## Formação

- **Engenharia de Software** — graduação em andamento
- Análise e Desenvolvimento de Sistemas
- Certificações em Banco de Dados — Instituto Federal / Aprenda Mais

## Estudando agora

Testes automatizados (Jest e Supertest), TypeScript e Docker — para levar os projetos acima
ao padrão que se espera de um time.
