$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$Owner = 'mkbraion'
$MarkerStart = '<!-- MKBRAION-POLISH:START -->'
$MarkerEnd   = '<!-- MKBRAION-POLISH:END -->'

function Write-Step([string]$Text, [ConsoleColor]$Color = 'Cyan') { Write-Host $Text -ForegroundColor $Color }
function Clean([string]$Text) { if ([string]::IsNullOrWhiteSpace($Text)) { return '' }; return (($Text.Trim() -replace '\s+',' ')) }
function Broken([string]$Text) { if ([string]::IsNullOrWhiteSpace($Text)) { return $false }; return ($Text -match '�|\?\?|[A-Za-zÀ-ÿ]\?[A-Za-zÀ-ÿ]') }
function Title([string]$Name) { $t=$Name -replace '[-_]',' '; $t=(Get-Culture).TextInfo.ToTitleCase($t.ToLower()); $t=$t -replace '\bApi\b','API' -replace '\bIa\b','IA' -replace '\bCrm\b','CRM' -replace '\bPwa\b','PWA' -replace '\bYt\b','YT'; return $t }

$KnownDescriptions = @{
 'mkbraion.github.io'='Portfólio pessoal de desenvolvimento de software com projetos full-stack, back-end, mobile, APIs, inteligência artificial e soluções web.'
 'mkbraion'='Perfil e portfólio de Nelson Neto (@mkbraion), com projetos de engenharia de software, desenvolvimento full-stack, back-end, mobile e inteligência artificial.'
 'SalesHub'='Plataforma SaaS para gestão de vendas com dashboard, produtos, integrações, histórico comercial e recursos de inteligência artificial.'
 'kaiafy'='KAIAfy — plataforma digital com automação e inteligência artificial para criação, gestão e evolução de experiências online.'
 'kaiafy-site'='Site institucional do KAIAfy, com apresentação do produto, recursos, proposta de valor e acesso à plataforma.'
 'site-psiquiatria'='Site profissional e responsivo para serviços de psiquiatria, com foco em apresentação, confiança, contato e experiência do paciente.'
 'miniguia-estudos-notebooklm'='Mini guia prático de estudos com NotebookLM e inteligência artificial para organizar fontes, revisar conteúdos e acelerar a aprendizagem.'
 'gerador-conteudo-ia'='Gerador de conteúdo com inteligência artificial para criar ideias, textos e materiais de marketing de forma rápida e estruturada.'
 'sites-para-profissionais'='Coleção de templates responsivos para sites profissionais de diferentes nichos, desenvolvidos para personalização rápida e publicação.'
 'crm-funil-vendas'='CRM de funil de vendas com interface Kanban, funcionamento offline, armazenamento local e sincronização com API própria.'
 'bot-whatsapp-ia'='Bot para WhatsApp com inteligência artificial, automação de atendimento e base para integrações com fluxos e serviços externos.'
 'loja-checkout'='E-commerce full-stack com checkout seguro, autenticação JWT, proteção contra adulteração de preços, rate limiting e API Node.js.'
 'crm-api'='API REST para CRM construída com Node.js, Express, Prisma e PostgreSQL, com autenticação JWT, bcrypt e isolamento seguro de dados.'
 'kaia-whatsapp'='Módulo KAIA para automação e atendimento via WhatsApp, integrando mensageria, inteligência artificial e fluxos de negócio.'
 'kaiafy-web'='Aplicação web do KAIAfy, reunindo a experiência principal da plataforma em uma interface moderna e responsiva.'
 'lefon-agenda'='Sistema web de agenda e gestão de visitas para equipes imobiliárias, utilizando Supabase, PostgreSQL e Row Level Security.'
 'kaia-fit'='Aplicação KAIA voltada a fitness e acompanhamento de rotina, com base para metas, evolução e experiências personalizadas.'
 'desafios-dio'='Repositório de estudos e desafios práticos da DIO, reunindo exercícios de programação e evolução técnica.'
 'kaia-imoveis'='Plataforma imobiliária do ecossistema KAIA para organização de imóveis, atendimento, oportunidades e experiência comercial.'
 'kaia-web'='Aplicação web principal do ecossistema KAIA, reunindo recursos de produtividade, automação e inteligência artificial.'
 'kaia-lucro'='Aplicação para gestão de lucro, vendas, estoque e indicadores financeiros, criada para facilitar o controle operacional de pequenos negócios.'
 'lefon-lucro-web'='Aplicação PWA em Flutter para gestão de revendedores: controle de vendas, lucro, estoque, caixa e fiado com integração Supabase.'
 'anotacoes-dev'='Repositório de estudos, anotações técnicas e snippets sobre programação, JavaScript, Git, GitHub, Flutter, Dart e desenvolvimento de software.'
 'otimizador-midia'='Ferramenta web para processamento de imagens e vídeos com FFmpeg WebAssembly, OCR com Tesseract.js e integração com backend de mídia.'
 'otimizador-midia-yt-backend'='Backend Node.js e Express para consulta e download de mídia com yt-dlp, incluindo CORS, rate limiting e processamento de arquivos.'
 'remax-pactual-agenda'='Agenda digital para organização de visitas, compromissos e rotina comercial de uma equipe do setor imobiliário.'
 'lefon-reverse-engineering'='Ferramenta em TypeScript para engenharia reversa, análise de código-fonte, inspeção estrutural e compreensão de projetos de software.'
 'Aider-Brasil'='Assistente de programação com IA no terminal, adaptado para português do Brasil, com integração a LLMs, Git e desenvolvimento assistido por IA.'
 'AstrBot-Brasil'='Plataforma de chatbot e automação com IA adaptada para português do Brasil, com foco em comunidade, extensibilidade e experiência brasileira.'
}

$KnownTopics = @{
 'SalesHub'=@('saas','sales','crm','artificial-intelligence','dashboard','backend','frontend','api','mobile')
 'kaiafy'=@('kaia','artificial-intelligence','automation','saas','fullstack')
 'kaiafy-site'=@('kaia','landing-page','frontend','website','responsive-design')
 'site-psiquiatria'=@('healthcare','psychiatry','website','frontend','responsive-design')
 'miniguia-estudos-notebooklm'=@('notebooklm','artificial-intelligence','education','study','productivity')
 'gerador-conteudo-ia'=@('artificial-intelligence','content-generation','marketing','automation','llm')
 'bot-whatsapp-ia'=@('whatsapp','chatbot','artificial-intelligence','automation','bot')
 'kaia-whatsapp'=@('whatsapp','kaia','chatbot','artificial-intelligence','automation')
 'kaiafy-web'=@('kaia','web-app','frontend','saas','artificial-intelligence')
 'kaia-fit'=@('fitness','health','kaia','mobile-app','productivity')
 'desafios-dio'=@('dio','programming','learning','challenges','education')
 'kaia-imoveis'=@('real-estate','kaia','crm','web-app','sales')
 'kaia-web'=@('kaia','artificial-intelligence','automation','web-app','fullstack','saas')
 'kaia-lucro'=@('finance','sales-management','inventory-management','profit','business')
 'remax-pactual-agenda'=@('real-estate','scheduling','crm','productivity','web-app')
 'ProjectEclipse'=@('software-engineering','automation','experimental','application')
 'Aider-Brasil'=@('python','aider','artificial-intelligence','ai-coding','coding-assistant','cli','developer-tools','llm','pair-programming','git','portuguese','pt-br')
 'AstrBot-Brasil'=@('chatbot','artificial-intelligence','llm','python','bot','automation','portuguese','pt-br','open-source')
 'lefon-reverse-engineering'=@('typescript','reverse-engineering','static-analysis','code-analysis','developer-tools','source-code-analysis','software-engineering','security-tools')
}

function InferTopics($Repo,[string[]]$Languages,[string]$Readme) {
 $list=New-Object System.Collections.Generic.List[string]
 foreach($t in @($Repo.repositoryTopics.name)){ if($t){$list.Add($t.ToLower())} }
 if($KnownTopics.ContainsKey($Repo.name)){ foreach($t in $KnownTopics[$Repo.name]){$list.Add($t)} }
 foreach($lang in $Languages){ switch($lang.ToLower()){'typescript'{$list.Add('typescript')};'javascript'{$list.Add('javascript')};'python'{$list.Add('python')};'dart'{$list.Add('dart');$list.Add('flutter')};'html'{$list.Add('html');$list.Add('frontend')};'css'{$list.Add('css');$list.Add('frontend')};'java'{$list.Add('java')};'kotlin'{$list.Add('kotlin');$list.Add('android')} } }
 $text=(($Repo.name+' '+$Repo.description+' '+$Readme)|Out-String).ToLower()
 $rules=@{'next\.js|nextjs'='nextjs';'react'='react';'nestjs|nest\.js'='nestjs';'express'='express';'node\.js|nodejs'='nodejs';'prisma'='prisma';'postgres|postgresql'='postgresql';'supabase'='supabase';'flutter'='flutter';'firebase'='firebase';'docker'='docker';'jwt'='jwt';'rest api|api rest'='rest-api';'whatsapp'='whatsapp';'openai|llm|intelig.ncia artificial|artificial intelligence'='artificial-intelligence';'crm'='crm';'e-commerce|ecommerce|checkout'='ecommerce';'youtube|yt-dlp'='youtube';'ffmpeg'='ffmpeg';'ocr|tesseract'='ocr';'reverse engineering|engenharia reversa'='reverse-engineering';'real estate|imobili.r'='real-estate';'pwa'='pwa';'kanban'='kanban';'vercel'='vercel'}
 foreach($p in $rules.Keys){if($text -match $p){$list.Add($rules[$p])}}
 return @($list|Where-Object{$_ -and $_.Length -le 50}|Sort-Object -Unique|Select-Object -First 20)
}

function DescriptionFor($Repo,[string[]]$Languages,[string]$Readme){
 if($KnownDescriptions.ContainsKey($Repo.name)){return $KnownDescriptions[$Repo.name]}
 $existing=Clean $Repo.description
 if($existing -and -not (Broken $existing)){return $existing}
 if($Readme){foreach($line in ($Readme -split "`n")){ $c=$line.Trim(); if($c -match '^#|^!\[|^\[!\[|^<|^```|^---|^\|' -or $c.Length -lt 35){continue}; $c=$c -replace '\[(.*?)\]\([^)]*\)','$1' -replace '[*_`>#]',''; $c=Clean $c; if($c.Length -gt 180){$c=$c.Substring(0,177).TrimEnd()+'...'}; if($c -and -not (Broken $c)){return $c} } }
 $stack=if($Languages.Count -gt 0){($Languages|Select-Object -First 3)-join ', '}else{'tecnologias modernas'}
 return "$(Title $Repo.name) — projeto de software desenvolvido com $stack, organizado para evolução, manutenção e experimentação contínua."
}

function Presentation($Repo,[string]$Description,[string[]]$Topics,[string]$Demo){
 $repoUrl="https://github.com/$Owner/$($Repo.name)"; $buttons=New-Object System.Collections.Generic.List[string]
 $buttons.Add("[![Repositório](https://img.shields.io/badge/GitHub-Repositório-181717?logo=github)]($repoUrl)")
 if($Demo){$buttons.Add("[![Demo ao vivo](https://img.shields.io/badge/Demo-Abrir%20aplicação-2ea44f?logo=vercel)]($Demo)")}
 $topicLine=if($Topics.Count -gt 0){'**Stack / tópicos:** ``'+(($Topics|Select-Object -First 12)-join '`` · ``')+'``'}else{''}
 return @"
$MarkerStart
<div align="center">

# $(Title $Repo.name)

**$Description**

$($buttons -join ' ')

</div>

$topicLine

> Projeto mantido por [@mkbraion](https://github.com/mkbraion).
$MarkerEnd
"@
}

Write-Step '==============================================' Green
Write-Step '  MKBRAION - GITHUB REPOSITORY POLISH' Green
Write-Step '==============================================' Green
if(-not(Get-Command gh -ErrorAction SilentlyContinue)){Write-Step 'ERRO: GitHub CLI não encontrado.' Red;exit 1}
gh auth status *> $null;if($LASTEXITCODE -ne 0){Write-Step 'ERRO: execute gh auth login primeiro.' Red;exit 1}

# Compatível com Windows PowerShell 5.1: força a enumeração do array JSON.
$raw = gh repo list $Owner --limit 100 --json name,description,homepageUrl,visibility,isArchived,repositoryTopics,url 2>$null
$parsed = ConvertFrom-Json -InputObject ($raw -join "`n")
$Repos = New-Object System.Collections.Generic.List[object]
foreach($r in $parsed){ [void]$Repos.Add($r) }
if($Repos.Count -eq 0){Write-Step 'ERRO: nenhum repositório encontrado.' Red;exit 1}

$logPath=Join-Path $env:USERPROFILE ('github-polish-'+(Get-Date -Format 'yyyy-MM-dd-HHmmss')+'.log')
"INÍCIO: $(Get-Date) | REPOSITÓRIOS: $($Repos.Count)"|Set-Content $logPath -Encoding utf8
$ok=0;$fail=0;$i=0
foreach($Repo in $Repos){
 $i++;Write-Step "[$i/$($Repos.Count)] $($Repo.name) [$($Repo.visibility)]"
 try{
  $apiRepo=gh api "repos/$Owner/$($Repo.name)" 2>$null|ConvertFrom-Json;if(-not $apiRepo){throw 'Não foi possível ler os metadados.'}
  $langObj=gh api "repos/$Owner/$($Repo.name)/languages" 2>$null|ConvertFrom-Json;$langs=@();if($langObj){$langs=@($langObj.PSObject.Properties.Name)}
  $readme='';$readmeInfo=$null
  try{$readmeInfo=gh api "repos/$Owner/$($Repo.name)/readme" 2>$null|ConvertFrom-Json;if($readmeInfo.content){$readme=[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String(($readmeInfo.content -replace '\s','')))}}catch{}
  $description=Clean (DescriptionFor $Repo $langs $readme);if($description.Length -gt 350){$description=$description.Substring(0,347).TrimEnd()+'...'}
  $topics=InferTopics $Repo $langs $readme
  $demo=Clean $Repo.homepageUrl
  if(-not $demo -and $apiRepo.has_pages -eq $true -and $Repo.visibility -eq 'public'){if($Repo.name -eq "$Owner.github.io"){$demo="https://$Owner.github.io/"}else{$demo="https://$Owner.github.io/$($Repo.name)/"}}
  $meta=@{description=$description};if($demo){$meta.homepage=$demo};$meta|ConvertTo-Json -Compress|gh api --method PATCH "repos/$Owner/$($Repo.name)" --input - *> $null;if($LASTEXITCODE -ne 0){throw 'Falha ao atualizar descrição/homepage.'}
  @{names=@($topics)}|ConvertTo-Json -Compress|gh api --method PUT "repos/$Owner/$($Repo.name)/topics" --input - *> $null;if($LASTEXITCODE -ne 0){throw 'Falha ao atualizar topics.'}
  if(-not $Repo.isArchived){
   $block=(Presentation $Repo $description $topics $demo).Trim()
   if($readmeInfo -and $readmeInfo.sha){
    if($readme -match [regex]::Escape($MarkerStart)){$pattern=[regex]::Escape($MarkerStart)+'[\s\S]*?'+[regex]::Escape($MarkerEnd);$new=[regex]::Replace($readme,$pattern,$block)}else{$new=$block+"`r`n`r`n"+$readme.TrimStart()}
    $payload=@{message='docs: improve repository presentation';content=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($new));sha=$readmeInfo.sha;branch=$apiRepo.default_branch}|ConvertTo-Json -Compress
    $payload|gh api --method PUT "repos/$Owner/$($Repo.name)/contents/$($readmeInfo.path)" --input - *> $null;if($LASTEXITCODE -ne 0){throw 'Metadados atualizados, mas houve falha ao atualizar README.'}
   }else{
    $new=$block+"`r`n`r`n## Sobre`r`n`r`n$description`r`n";$payload=@{message='docs: add professional README';content=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($new));branch=$apiRepo.default_branch}|ConvertTo-Json -Compress
    $payload|gh api --method PUT "repos/$Owner/$($Repo.name)/contents/README.md" --input - *> $null;if($LASTEXITCODE -ne 0){throw 'Metadados atualizados, mas houve falha ao criar README.'}
   }
  }
  "OK | $($Repo.name) | $description | topics=$($topics -join ',') | demo=$demo"|Add-Content $logPath -Encoding utf8;Write-Step '  OK: descrição, topics e apresentação revisadas.' Green;$ok++
 }catch{"ERRO | $($Repo.name) | $($_.Exception.Message)"|Add-Content $logPath -Encoding utf8;Write-Step "  ERRO: $($_.Exception.Message)" Red;$fail++}
 Start-Sleep -Milliseconds 250
}
"FIM: $(Get-Date) | OK=$ok | FALHAS=$fail"|Add-Content $logPath -Encoding utf8
Write-Step '';Write-Step '==============================================' Green;Write-Step "CONCLUÍDO: $ok OK | $fail falha(s) | total $($Repos.Count)" Green;Write-Step "Log: $logPath" Cyan;Write-Step '==============================================' Green
