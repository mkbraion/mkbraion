$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$Owner = 'mkbraion'
$MarkerStart = '<!-- MKBRAION-POLISH:START -->'
$MarkerEnd = '<!-- MKBRAION-POLISH:END -->'

function Step([string]$Text,[ConsoleColor]$Color='Cyan'){ Write-Host $Text -ForegroundColor $Color }
function Clean([object]$Value){ if($null -eq $Value){ return '' }; $s=[string]$Value; if([string]::IsNullOrWhiteSpace($s)){ return '' }; return (($s.Trim() -replace '\s+',' ')) }
function NiceTitle([string]$Name){ if([string]::IsNullOrWhiteSpace($Name)){return 'Projeto'}; $t=$Name -replace '[-_]',' '; $t=(Get-Culture).TextInfo.ToTitleCase($t.ToLower()); return ($t -replace '\bApi\b','API' -replace '\bIa\b','IA' -replace '\bCrm\b','CRM' -replace '\bPwa\b','PWA' -replace '\bYt\b','YT') }

$Descriptions = @{
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
 'ProjectEclipse'='Projeto experimental de software voltado a automação, engenharia de aplicações e exploração de novas arquiteturas.'
 'Controle-Est-vel'='Sistema de controle e organização desenvolvido como projeto de software, preservado como referência técnica e histórica.'
}

$ExtraTopics = @{
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
 'anotacoes-dev'=@('programming','developer-notes','snippets','learning','javascript','git','github','flutter','dart','software-development')
 'Controle-Est-vel'=@('software','management','archive','portfolio')
}

function GetTopics($Repo,[string[]]$Languages,[string]$Readme){
 $all=New-Object System.Collections.Generic.List[string]
 if($Repo.repositoryTopics){ foreach($x in @($Repo.repositoryTopics)){ if($x -and $x.name){ $all.Add(([string]$x.name).ToLower()) } } }
 if($ExtraTopics.ContainsKey([string]$Repo.name)){ foreach($x in $ExtraTopics[[string]$Repo.name]){ $all.Add($x) } }
 foreach($lang in @($Languages)){
  if(-not $lang){continue}; switch(([string]$lang).ToLower()){
   'typescript'{$all.Add('typescript')}; 'javascript'{$all.Add('javascript')}; 'python'{$all.Add('python')}; 'dart'{$all.Add('dart');$all.Add('flutter')};
   'html'{$all.Add('html');$all.Add('frontend')}; 'css'{$all.Add('css');$all.Add('frontend')}; 'java'{$all.Add('java')}; 'kotlin'{$all.Add('kotlin');$all.Add('android')}
  }
 }
 $text=(Clean (($Repo.name.ToString())+' '+(Clean $Repo.description)+' '+(Clean $Readme))).ToLower()
 $rules=@{
  'next\.js|nextjs'='nextjs'; 'react'='react'; 'nestjs|nest\.js'='nestjs'; 'express'='express'; 'node\.js|nodejs'='nodejs';
  'prisma'='prisma'; 'postgres|postgresql'='postgresql'; 'supabase'='supabase'; 'flutter'='flutter'; 'firebase'='firebase'; 'docker'='docker';
  'jwt'='jwt'; 'rest api|api rest'='rest-api'; 'whatsapp'='whatsapp'; 'openai|llm|intelig.ncia artificial|artificial intelligence'='artificial-intelligence';
  'crm'='crm'; 'e-commerce|ecommerce|checkout'='ecommerce'; 'youtube|yt-dlp'='youtube'; 'ffmpeg'='ffmpeg'; 'ocr|tesseract'='ocr';
  'reverse engineering|engenharia reversa'='reverse-engineering'; 'real estate|imobili.r'='real-estate'; 'pwa'='pwa'; 'kanban'='kanban'; 'vercel'='vercel'
 }
 foreach($p in $rules.Keys){ if($text -match $p){ $all.Add($rules[$p]) } }
 return @($all | Where-Object{$_ -and $_.Length -le 50} | Sort-Object -Unique | Select-Object -First 20)
}

function MakeBlock($Repo,[string]$Description,[string[]]$Topics,[string]$Demo){
 $name=[string]$Repo.name; $repoUrl="https://github.com/$Owner/$name"; $buttons=@("[![Repositório](https://img.shields.io/badge/GitHub-Repositório-181717?logo=github)]($repoUrl)")
 if(-not [string]::IsNullOrWhiteSpace($Demo)){ $buttons += "[![Demo ao vivo](https://img.shields.io/badge/Demo-Abrir%20aplicação-2ea44f?logo=vercel)]($Demo)" }
 $topicLine=''; if(@($Topics).Count -gt 0){ $topicLine='**Stack / tópicos:** ``'+((@($Topics)|Select-Object -First 12)-join '`` · ``')+'``' }
 return "$MarkerStart`r`n<div align=`"center`">`r`n`r`n# $(NiceTitle $name)`r`n`r`n**$Description**`r`n`r`n$($buttons -join ' ')`r`n`r`n</div>`r`n`r`n$topicLine`r`n`r`n> Projeto mantido por [@mkbraion](https://github.com/mkbraion).`r`n$MarkerEnd"
}

Step '==============================================' Green
Step '  MKBRAION - GITHUB REPOSITORY POLISH' Green
Step '==============================================' Green
if(-not(Get-Command gh -ErrorAction SilentlyContinue)){ Step 'ERRO: GitHub CLI não encontrado.' Red; exit 1 }
gh auth status *> $null; if($LASTEXITCODE -ne 0){ Step 'ERRO: execute gh auth login primeiro.' Red; exit 1 }

$raw=gh repo list $Owner --limit 100 --json name,description,homepageUrl,visibility,isArchived,repositoryTopics,url 2>$null
$parsed=ConvertFrom-Json -InputObject ($raw -join "`n")
$Repos=New-Object System.Collections.Generic.List[object]; foreach($r in @($parsed)){ [void]$Repos.Add($r) }
if($Repos.Count -eq 0){ Step 'ERRO: nenhum repositório encontrado.' Red; exit 1 }

$log=Join-Path $env:USERPROFILE ('github-polish-'+(Get-Date -Format 'yyyy-MM-dd-HHmmss')+'.log')
"INÍCIO: $(Get-Date) | TOTAL=$($Repos.Count)" | Set-Content $log -Encoding utf8
$ok=0;$fail=0;$i=0

foreach($Repo in $Repos){
 $i++; $name=[string]$Repo.name; Step "[$i/$($Repos.Count)] $name [$($Repo.visibility)]"
 $wasArchived=($Repo.isArchived -eq $true)
 try{
  if($wasArchived){
   Step '  Arquivado: liberando temporariamente para manutenção...' DarkYellow
   @{archived=$false}|ConvertTo-Json -Compress|gh api --method PATCH "repos/$Owner/$name" --input - *> $null
   if($LASTEXITCODE -ne 0){ throw 'Não foi possível desarquivar temporariamente.' }
   Start-Sleep -Milliseconds 400
  }

  $api=gh api "repos/$Owner/$name" 2>$null|ConvertFrom-Json; if(-not $api){ throw 'Não foi possível ler metadados.' }
  $langObj=gh api "repos/$Owner/$name/languages" 2>$null|ConvertFrom-Json; $langs=@(); if($langObj){ $langs=@($langObj.PSObject.Properties.Name) }

  $readme=''; $readmeInfo=$null
  try{
   $ri=gh api "repos/$Owner/$name/readme" 2>$null|ConvertFrom-Json
   if($ri){ $readmeInfo=$ri; if($ri.content){ $readme=[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String((([string]$ri.content) -replace '\s',''))) } }
  }catch{ $readmeInfo=$null; $readme='' }

  $description=''; if($Descriptions.ContainsKey($name)){ $description=[string]$Descriptions[$name] } else { $description=Clean $Repo.description }
  if([string]::IsNullOrWhiteSpace($description)){ $stack=if(@($langs).Count -gt 0){(@($langs)|Select-Object -First 3)-join ', '}else{'tecnologias modernas'}; $description="$(NiceTitle $name) — projeto de software desenvolvido com $stack, organizado para evolução e manutenção contínua." }
  if($description.Length -gt 350){ $description=$description.Substring(0,347).TrimEnd()+'...' }

  $topics=@(GetTopics $Repo $langs $readme)
  $demo=Clean $Repo.homepageUrl
  if(-not $demo -and $api.has_pages -eq $true -and $Repo.visibility -eq 'public'){ if($name -eq "$Owner.github.io"){$demo="https://$Owner.github.io/"}else{$demo="https://$Owner.github.io/$name/"} }

  $meta=@{description=$description}; if($demo){$meta.homepage=$demo}
  $meta|ConvertTo-Json -Compress|gh api --method PATCH "repos/$Owner/$name" --input - *> $null; if($LASTEXITCODE -ne 0){ throw 'Falha ao atualizar descrição/homepage.' }
  @{names=@($topics)}|ConvertTo-Json -Compress|gh api --method PUT "repos/$Owner/$name/topics" --input - *> $null; if($LASTEXITCODE -ne 0){ throw 'Falha ao atualizar topics.' }

  $block=MakeBlock $Repo $description $topics $demo
  if($readmeInfo -and $readmeInfo.sha -and $readmeInfo.path){
   $old=[string]$readme; if($null -eq $old){$old=''}
   if($old.Contains($MarkerStart) -and $old.Contains($MarkerEnd)){
    $pattern=[regex]::Escape($MarkerStart)+'[\s\S]*?'+[regex]::Escape($MarkerEnd)
    $new=[regex]::Replace($old,$pattern,[System.Text.RegularExpressions.MatchEvaluator]{param($m)$block})
   }else{ $new=$block+"`r`n`r`n"+$old.TrimStart() }
   if($new -ne $old){
    $b64=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($new))
    @{message='docs: polish repository presentation';content=$b64;sha=$readmeInfo.sha;branch=$api.default_branch}|ConvertTo-Json -Compress|gh api --method PUT "repos/$Owner/$name/contents/$($readmeInfo.path)" --input - *> $null
    if($LASTEXITCODE -ne 0){ throw 'Metadados atualizados, mas houve falha ao atualizar README.' }
   }
  }else{
   $new=$block+"`r`n`r`n## Sobre`r`n`r`n$description`r`n"; $b64=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($new))
   @{message='docs: add professional README';content=$b64;branch=$api.default_branch}|ConvertTo-Json -Compress|gh api --method PUT "repos/$Owner/$name/contents/README.md" --input - *> $null
   if($LASTEXITCODE -ne 0){ throw 'Metadados atualizados, mas houve falha ao criar README.' }
  }

  if($wasArchived){
   @{archived=$true}|ConvertTo-Json -Compress|gh api --method PATCH "repos/$Owner/$name" --input - *> $null
   if($LASTEXITCODE -ne 0){ throw 'Alterações aplicadas, mas não foi possível restaurar o estado arquivado.' }
   Step '  Estado arquivado restaurado.' DarkYellow
  }

  "OK | $name | archived-restored=$wasArchived | topics=$($topics -join ',')" | Add-Content $log -Encoding utf8
  Step '  OK: descrição, topics e apresentação revisadas.' Green; $ok++
 }catch{
  $err=$_.Exception.Message
  if($wasArchived){
   $state=gh api "repos/$Owner/$name" --jq '.archived' 2>$null
   if(($state -join '').Trim() -eq 'false'){ @{archived=$true}|ConvertTo-Json -Compress|gh api --method PATCH "repos/$Owner/$name" --input - *> $null }
  }
  "ERRO | $name | $err" | Add-Content $log -Encoding utf8
  Step "  ERRO: $err" Red; $fail++
 }
 Start-Sleep -Milliseconds 250
}

"FIM: $(Get-Date) | OK=$ok | FALHAS=$fail" | Add-Content $log -Encoding utf8
Step ''
Step '==============================================' Green
Step "CONCLUÍDO: $ok OK | $fail falha(s) | total $($Repos.Count)" Green
Step "Log: $log" Cyan
Step '==============================================' Green
