$ErrorActionPreference = 'Continue'
$Owner = 'mkbraion'

function Escape-JsonAscii([string]$Text) {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append('"')
    foreach ($ch in $Text.ToCharArray()) {
        $n = [int][char]$ch
        switch ($ch) {
            '"' { [void]$sb.Append('\"'); continue }
            '\' { [void]$sb.Append('\\'); continue }
            "`b" { [void]$sb.Append('\b'); continue }
            "`f" { [void]$sb.Append('\f'); continue }
            "`n" { [void]$sb.Append('\n'); continue }
            "`r" { [void]$sb.Append('\r'); continue }
            "`t" { [void]$sb.Append('\t'); continue }
        }
        if ($n -lt 32 -or $n -gt 126) {
            [void]$sb.Append(('\u{0:x4}' -f $n))
        } else {
            [void]$sb.Append($ch)
        }
    }
    [void]$sb.Append('"')
    return $sb.ToString()
}

function Set-RepoDescription([string]$Repo,[string]$Description,[bool]$Archived) {
    $wasArchived = $Archived
    try {
        if ($wasArchived) {
            '{"archived":false}' | gh api --method PATCH "repos/$Owner/$Repo" --input - *> $null
            if ($LASTEXITCODE -ne 0) { throw 'falha ao desarquivar temporariamente' }
            Start-Sleep -Milliseconds 300
        }

        $payload = '{"description":' + (Escape-JsonAscii $Description) + '}'
        $payload | gh api --method PATCH "repos/$Owner/$Repo" --input - *> $null
        if ($LASTEXITCODE -ne 0) { throw 'falha ao atualizar descrição' }

        if ($wasArchived) {
            '{"archived":true}' | gh api --method PATCH "repos/$Owner/$Repo" --input - *> $null
            if ($LASTEXITCODE -ne 0) { throw 'descrição atualizada, mas falhou ao restaurar arquivo' }
        }

        Write-Host "OK  $Repo" -ForegroundColor Green
        return $true
    }
    catch {
        if ($wasArchived) { '{"archived":true}' | gh api --method PATCH "repos/$Owner/$Repo" --input - *> $null }
        Write-Host "ERRO $Repo - $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host 'ERRO: GitHub CLI não encontrado.' -ForegroundColor Red
    exit 1
}

gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Host 'ERRO: execute gh auth login primeiro.' -ForegroundColor Red
    exit 1
}

$Descriptions = [ordered]@{
    'mkbraion' = 'Perfil e portfólio de Nelson Neto (@mkbraion), com projetos de engenharia de software, desenvolvimento full-stack, back-end, mobile e inteligência artificial.'
    'mkbraion.github.io' = 'Portfólio pessoal de desenvolvimento de software com projetos full-stack, back-end, mobile, APIs, inteligência artificial e soluções web.'
    'AstrBot-Brasil' = 'Plataforma de chatbot e automação com IA adaptada para português do Brasil, com foco em comunidade, extensibilidade e experiência brasileira.'
    'Aider-Brasil' = 'Assistente de programação com IA no terminal, adaptado para português do Brasil, com integração a LLMs, Git e desenvolvimento assistido por IA.'
    'lefon-reverse-engineering' = 'Ferramenta em TypeScript para engenharia reversa, análise de código-fonte, inspeção estrutural e compreensão de projetos de software.'
    'loja-checkout' = 'E-commerce full-stack com checkout seguro, autenticação JWT, proteção contra adulteração de preços, rate limiting e API Node.js.'
    'kaiafy' = 'KAIAfy — plataforma digital com automação e inteligência artificial para criação, gestão e evolução de experiências online.'
    'kaiafy-site' = 'Site institucional do KAIAfy, com apresentação do produto, recursos, proposta de valor e acesso à plataforma.'
    'lefon-agenda' = 'Sistema web de agenda e gestão de visitas para equipes imobiliárias, utilizando Supabase, PostgreSQL e Row Level Security.'
    'lefon-lucro-web' = 'Aplicação PWA em Flutter para gestão de revendedores: controle de vendas, lucro, estoque, caixa e fiado com integração Supabase.'
    'otimizador-midia' = 'Ferramenta web para processamento de imagens e vídeos com FFmpeg WebAssembly, OCR com Tesseract.js e integração com backend de mídia.'
    'SalesHub' = 'Plataforma SaaS para gestão de vendas com dashboard, produtos, integrações, histórico comercial e recursos de inteligência artificial.'
    'site-psiquiatria' = 'Site profissional e responsivo para serviços de psiquiatria, com foco em apresentação, confiança, contato e experiência do paciente.'
    'gerador-conteudo-ia' = 'Gerador de conteúdo com inteligência artificial para criar ideias, textos e materiais de marketing de forma rápida e estruturada.'
    'sites-para-profissionais' = 'Coleção de templates responsivos para sites profissionais de diferentes nichos, desenvolvidos para personalização rápida e publicação.'
    'crm-funil-vendas' = 'CRM de funil de vendas com interface Kanban, funcionamento offline, armazenamento local e sincronização com API própria.'
    'bot-whatsapp-ia' = 'Bot para WhatsApp com inteligência artificial, automação de atendimento e base para integrações com fluxos e serviços externos.'
    'crm-api' = 'API REST para CRM construída com Node.js, Express, Prisma e PostgreSQL, com autenticação JWT, bcrypt e isolamento seguro de dados.'
    'kaia-whatsapp' = 'Módulo KAIA para automação e atendimento via WhatsApp, integrando mensageria, inteligência artificial e fluxos de negócio.'
    'kaia-fit' = 'Aplicação KAIA voltada a fitness e acompanhamento de rotina, com base para metas, evolução e experiências personalizadas.'
    'kaia-imoveis' = 'Plataforma imobiliária do ecossistema KAIA para organização de imóveis, atendimento, oportunidades e experiência comercial.'
    'kaia-web' = 'Aplicação web principal do ecossistema KAIA, reunindo recursos de produtividade, automação e inteligência artificial.'
    'remax-pactual-agenda' = 'Agenda digital para organização de visitas, compromissos e rotina comercial de uma equipe do setor imobiliário.'
    'ProjectEclipse' = 'Projeto experimental de software voltado a automação, engenharia de aplicações e exploração de novas arquiteturas.'
    'kaiafy-web' = 'Aplicação web do KAIAfy, reunindo a experiência principal da plataforma em uma interface moderna e responsiva.'
    'otimizador-midia-yt-backend' = 'Backend Node.js e Express para consulta e download de mídia com yt-dlp, incluindo CORS, rate limiting e processamento de arquivos.'
    'kaia-lucro' = 'Aplicação para gestão de lucro, vendas, estoque e indicadores financeiros, criada para facilitar o controle operacional de pequenos negócios.'
    'anotacoes-dev' = 'Repositório de estudos, anotações técnicas e snippets sobre programação, JavaScript, Git, GitHub, Flutter, Dart e desenvolvimento de software.'
    'Controle-Est-vel' = 'Sistema de controle e organização desenvolvido como projeto de software, preservado como referência técnica e histórica.'
    'miniguia-estudos-notebooklm' = 'Mini guia prático de estudos com NotebookLM e inteligência artificial para organizar fontes, revisar conteúdos e acelerar a aprendizagem.'
    'desafios-dio' = 'Repositório de estudos e desafios práticos da DIO, reunindo exercícios de programação e evolução técnica.'
}

$repoRaw = gh repo list $Owner --limit 100 --json name,isArchived 2>$null
$repoList = ConvertFrom-Json -InputObject ($repoRaw -join "`n")
$archiveMap = @{}
foreach ($r in @($repoList)) { $archiveMap[[string]$r.name] = ($r.isArchived -eq $true) }

Write-Host '==============================================' -ForegroundColor Cyan
Write-Host '  CORREÇÃO DE DESCRIÇÕES UTF-8 - MKBRAION' -ForegroundColor Cyan
Write-Host '==============================================' -ForegroundColor Cyan

$ok = 0
$fail = 0
foreach ($entry in $Descriptions.GetEnumerator()) {
    $name = [string]$entry.Key
    $desc = [string]$entry.Value
    $archived = $false
    if ($archiveMap.ContainsKey($name)) { $archived = [bool]$archiveMap[$name] }
    if (Set-RepoDescription $name $desc $archived) { $ok++ } else { $fail++ }
    Start-Sleep -Milliseconds 150
}

Write-Host ''
Write-Host "CONCLUÍDO: $ok OK | $fail falha(s) | total $($Descriptions.Count)" -ForegroundColor $(if($fail -eq 0){'Green'}else{'Yellow'})
