\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tccv}
\LoadClass[10pt]{scrartcl}

\makeatletter
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\makeatother


\setcounter{secnumdepth}{-1}
\RequirePackage[hmargin=1.25cm,vmargin=1.25cm,twocolumn,columnsep=1.25cm]{geometry}
\RequirePackage{fontspec}
\RequirePackage{bookman,etoolbox,hyperref,marvosym,needspace,tabularx,xcolor,fontawesome5}

\newcommand\ucwords[2][3]{%
    \providecommand\directlua[1]{#2}%
    \directlua{%
	local minlen=tonumber("#1")
	local src="\luaescapestring{\unexpanded{#2}}"
	local dst={}
	for w in src:gmatch('[^\string\%s]+') do
	    if w:len() >= minlen then w = w:sub(1,1):upper()..w:sub(2) end
	    table.insert(dst, w)
	end
	tex.print(dst)}}

\pagestyle{empty}
\setlength\parindent{0pt}
\color[HTML]{303030} % Default foreground color
\definecolor{link}{HTML}{506060} % Hyperlinks
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}
\setkomafont{disposition}{\color[HTML]{801010}}
\setkomafont{section}{\scshape\Large\mdseries}

\renewcommand\part[1]{%
    \twocolumn[%
    \begin{center}
	\vskip-\lastskip%
	{\usekomafont{part} #1} \medskip\\
	{\fontfamily{pzc}\selectfont\huge Ansioluettelo, \today}
	\bigskip
    \end{center}]}

\newcommand\partEng[1]{%
	\twocolumn[%
	\begin{center}
		\vskip-\lastskip%
		{\usekomafont{part} #1} \medskip\\
		{\fontfamily{pzc}\selectfont\huge Curriculum Vitae, \today}
		\bigskip
	\end{center}]}

% Overrides the \section command to capitalize every
% word for cosmetic purposes and draws a rule under it.
\makeatletter
\let\old@section\section
\renewcommand\section[2][]{%
    \old@section[#1]{\ucwords{#2}}%
    \newdimen\raising%
    \raising=\dimexpr-0.7\baselineskip\relax%
    \vskip\raising\hrule height 0.4pt\vskip-\raising}
\makeatother

\newcommand\ifjob[3]{%
    \edef\JOBNAME{\jobname}%
    \edef\PIVOT{\detokenize{#1}}%
    \ifdefstrequal{\JOBNAME}{\PIVOT}{#2}{#3}%
}

% Renders a personal data box:
\newcommand\personal[5][]{%
    \needspace{0.5\textheight}%
    \newdimen\boxwidth%
    \boxwidth=\dimexpr\linewidth-2\fboxsep\relax%
    \colorbox[HTML]{F5DD9D}{%
    \begin{tabularx}{\boxwidth}{c|X}
    \ifstrempty{#1}{}{ \faMale & {#1}\smallskip\\}
    \faHome & {#2}\smallskip\\
    \faPhone     & {#3}\smallskip\\
    \faMailForward      & \href{mailto:#4}{#4} \, | \, \href{#5}{\faGithub} \
    \end{tabularx}}}
\newenvironment{eventlist}{%
    \newcommand*\inskip{}
    \renewcommand\item[3]{%
	\inskip%
	{\raggedleft\sc ##1\\[1pt]}
	{##2}\\[2pt]
	{\Large\it ##3}
	\medskip
	\renewcommand\inskip{\bigskip}}}
    {\bigskip}
\newenvironment{yearlist}{%
    \renewcommand\item[4][]{%
	{\sc ##2} & {\bfseries ##3} \\
	\ifstrempty{##1}{}{& {\sc ##1} \\}
	& {\it ##4}\medskip\\}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
\newenvironment{factlist}{%
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    \renewcommand\item[2]{%
	\textsc{##1} & {\raggedright ##2\medskip\\}\\[\unbaseline]}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
    