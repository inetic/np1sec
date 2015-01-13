<TeXmacs|1.99.2>

<style|generic>

<\body>
  <doc-data|<doc-title|Sketch of Security Proof for (n+1)Sec Protocol>>

  The (n+1)Sec protocol is composed of following sub protocol:

  <\enumerate>
    1. <strong|TDH>: Triple DH deniable Authentication

    2. <strong|FAGKE>: Flexible Authenticated Group Key Exchange protocol
    presented in <cite|AMP10>

    3. <strong|SecCom>: Secure (authenticated confidential) Send and Receive.

    4. <strong|TCA>: Transcript Consistency Assurance.
  </enumerate>

  The threat model for each of these protocol is described in Section VI. The
  security of FAGKE is proven in the presented threat model. The SecComm
  consists of convential ``sign'' and ``encrypt'' functions and its security
  has been studied as a subprotocol to various protocols. We are not aware of
  any existing proof for TDH and TCA subprotocol.

  The sketch of the proof goes as follows, in Section
  <reference|sect-tdh-sec> and Section <reference|sect-tca-sec> we give
  convential formal proof of the security properties of TDH and TCA
  respectively. In Section <reference|sect-np1sec-pclize> we reforumlates the
  proves of all four protocols in Protocol Composition Logic (PCL). In
  Section <reference|sect-comp-sec>, we proof the security of (n+1)sec by
  proving the relative security of above sub prorotocol in relation to each
  other:

  <\enumerate>
    <item><math|Q<rsub|1>> as Parallel composition of TDH and FAGKE.

    <item>Sequential composition of <math|Q<rsub|1>> and SecCom.

    <item> Parallel compostion of SecCom and TCA.
  </enumerate>

  <section|Security of Triple Diffie-Hellman Authentication>

  <subsection|The Triple Diffie-Hellman Protocol>

  <\float|float|tbh>
    <big-table|<tabular|<tformat|<table|<row|<cell|Round
    1>|<cell|<math|A\<rightarrow\>B: <rprime|''>A<rprime|''>,g<rsup|a>>>|<cell|<math|B\<rightarrow\>A:<rprime|''>B<rprime|''>,g<rsup|b>>>>|<row|<cell|Key
    Computation>|<cell|<math|k\<leftarrow\>H<around*|(|<around*|(|g<rsup|b>|)><rsup|A>\|<around*|(|g<rsup|B>|)><rsup|a>\|<around*|(|g<rsup|b>|)><rsup|a>|)>>>|<cell|<math|k\<leftarrow\>H<around*|(|<around*|(|g<rsup|A>|)><rsup|b>\|<around*|(|g<rsup|a>|)><rsup|B>\|<around*|(|g<rsup|a>|)><rsup|b>|)>>>>|<row|<cell|Round
    2>|<cell|<math|Enc<rsub|k><around*|(|H<around*|(|k,A|)>|)>>>|<cell|<math|Enc<rsub|k><around*|(|H<around*|(|k,B|)>|)>>>>>>>|>
  </float>Assuming that <math|A> and <math|B> are represeneted by long term
  public key <math|g<rsup|A>> and <math|g<rsup|B>> respectively:

  <subsection|The deniablity of TDH>

  <label|sect-tdh-sec> We will prove a parallel to Theorem 4 <cite|GKR06>
  which proves the deniability of SKEME. We use the notation which are
  introduced in Section <reference|sect-deniabl-adv>. Following the same
  notation:

  <\definition>
    By <math|Adv<rsub|deny><rsup|\<ast\>>> we represent the party which
    represent the interaction of the Simulator <math|Sim> with the adverasy.
    In other word, <math|Adv<rsup|\<ast\>><rsub|deny>> has access to all
    information which <math|Adv<rsub|deny>> possess.
  </definition>

  <\theorem>
    If Computational Diffie-Hellman (CDH) is interactable then Triple DH
    Algorithm is deniable.
  </theorem>

  <\proof>
    We build <math|Sim<rsub|>> which interacts with <math|Adv<rsub|deny>>. We
    show that if <math|\<cal-J\>> is able to distinguish
    <math|Trans<rsub|Sim>> from <math|Trans<rsub|Real>>, ze should be able to
    solve CDH as well.

    Intuitively, when <math|\<cal-A\><rsub|deny>> sends <math|g<rsup|a>> to
    <math|<with|math-font|cal|>\<cal-S\><rsub|deny>>,
    <math|<with|math-font|cal|>\<cal-S\><rsub|deny>><math|> inquire
    <math|\<cal-A\><rsub|deny>> for <math|a>, in this way
    <math|<with|math-font|cal|>\<cal-S\><rsub|deny>> also can compute the
    same key <math|k> by asking <math|\<cal-A\><rsub|deny><rsup|\<ast\>>>. If
    <math|\<cal-A\><rsub|deny>> has chosen
    <math|g<rsup|a>\<in\>Tr<around*|(|B|)>> or just chosen a random element
    of the group without knowing its DLP, then <math|\<cal-S\><rsub|deny>>
    will choose a random exponent <math|a<rprime|'>> and computes the key
    <math|k> based on that and computes the confirmation value using
    <math|k>. Due to hardship of CDH this value is indistinguishable from a
    <math|k> generated by <math|B>

    Now we suppose that the TDH is not deniable and we build a solver for
    CDH. First we note that if <math|\<cal-A\><rsub|deny>> engages in an
    honest interaction with <math|B> there is no way that <math|\<cal-J\>>
    can distinguish between the <math|T<around*|(|\<cal-A\><rsub|deny><around*|(|Aux|)>|)>>
    and <math|T<around*|(|\<cal-S\><rsub|deny><around*|(|Aux|)>|)>>. As
    <math|\<cal-A\><rsub|deny>> is able to generate the very exact transcript
    without help of <math|B>. Therefore, logically, the only possibility for
    <math|\<cal-J\>> to distinguish <math|T<around*|(|\<cal-A\><rsub|deny><around*|(|Aux|)>|)>>
    and <math|T<around*|(|\<cal-S\><rsub|deny><around*|(|Aux|)>|)>> is when
    <math|\<cal-A\><rsub|deny>> present <math|\<cal-J\>> with a transcript
    that <math|\<cal-A\><rsub|deny>> is not able to generate zirself. The
    only variable that <math|\<cal-A\><rsub|deny>> has control over in the
    course of the exchange is <math|g<rsup|a>> and therefore the only way
    <math|\<cal-A\><rsub|deny>> is able to claim that ze were unable to
    generate the geneuine \ <math|T<around*|(|\<cal-A\><rsub|deny><around*|(|Aux|)>|)>>
    is by submiting <math|g<rsup|a>> which zirself does not know about its
    <math|a> exponent.

    In such case, assuming the undeniability of TDH we have an
    <math|\<varepsilon\>> such that

    <\equation*>
      <math|>max<rsub|all \<cal-J\>><rsub|>\|2Pr(Output<around*|(|\<cal-J\>,Aux|)>
      = b) -1\|\<gtr\>\<varepsilon\>
    </equation*>

    The solver <math|\<cal-A\><rsub|CDH>> receives a triple
    <math|<around*|(|g,g<rsup|a>,g<rsup|b>|)>> and should compute
    <math|g<rsup|a b>>. To that end, assuming long term identiy
    <math|g<rsup|A>> for some <math|\<cal-A\><rsub|deny>>, ze engages ,in a
    TDH key exchange with a hypothetical automated party
    <math|\<cal-A\><rsup|\<ast\>>> with long term private key <math|B> who
    generates <math|g<rsup|b>> as the ephemeral key as well.
    <math|\<cal-A\><rsub|CDH>>, then toss a coin and based on the result it
    either choose a random <math|a<rprime|'>> and compute
    <math|g<rprime|'>=g<rsup|a<rprime|'>>> or set
    <math|g<rprime|'>=g<rsup|a>,>then ze submits
    <math|h<rsub|0>=H<around*|(|g<rsup|b><rsup|
    A>\<nocomma\>,g<rprime|'><rsup|B>,g<rsup|b a<rprime|'>>|)>> along side
    with <math|<around*|(|g<rsup|B>,g<rsup|b>|)>> to the <math|\<cal-J\>> as
    a proof of engagement with <math|\<cal-A\><rsup|\<ast\>>>. Due to
    undeniability assumption

    <\equation*>
      Output<around*|(|\<cal-J\>,Aux|)><around*|(|h<rsub|0>,<around*|(|A,g<rsup|a>,B,g<rsup|b>|)>|)>=b
    </equation*>

    with significant probablity as means <math|\<cal-J\>> is able to
    distinguish <math|T<around*|(|\<cal-A\><rsub|deny><around*|(|Aux|)>|)>>
    and <math|T<around*|(|\<cal-S\><rsub|deny><around*|(|Aux|)>|)>> with high
    probablity. Therefore <math|\<cal-J\>> is able to decide if:

    <\equation*>
      h<rsub|0><long-arrow|\<rubber-equal\>|?>\<nocomma\>H<around*|(|g<rsup|b
      A>\<nocomma\>,<around*|(|g<rsup|a >|)><rsup|B>,<around*|(|g<rsup|a>|)><rsup|b>|)>
    </equation*>

    Because <math|H> is a random oracle the only way that the judge is able
    to distinguish the second value from the real value is to have knowledge
    about the exact pre-image: <math|g<rsup|b
    A>\<nocomma\>,<around*|(|g<rsup|a >|)><rsup|B>,<around*|(|g<rsup|a>|)><rsup|b>>.
    Using the information in the transcript <math|\<cal-J\>> can compute
    <math|g<rsup|b A>\<nocomma\>,<around*|(|g<rsup|a >|)><rsup|B>>, but still
    has to compute <math|g<rsup|ab>> using <math|g<rsup|a>> and
    <math|g<rsup|b>> with high probablity without knowing <math|a> or
    <math|b>, at this point <math|\<cal-A\><rsub|CDH>> is publishing the
    value of <math|g<rsup|a b>>.

    \;
  </proof>

  <subsection|Confidentiality and Authenticity of TDH>

  \;

  <section|Security of (n+1)sec authenticated group key exchange>

  In this section we prove the security of (n+1)sec group key exchange in the
  proposed adversarial model. Because the key exchange is essentially FAKE
  with only difference is that the traditional DH key exchange replaced by
  TDH, we prove the security of (n+1)sec GKE based on the security of FAKE.

  <subsection|Security of GKE>

  We prove Theorem <reference|thrm-np1sec-gke>. Theorem\ 

  <section|Security of Transcript Consistency Assurance>

  <label|sect-tca-sec>

  <section|(n+1)Sec components in PCL Langugae>

  <label|sect-np1sec-pclize>

  <section|Security of composed sub protocols>

  <label|sect-comp-sec>
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|5|?>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|1|2>>
    <associate|auto-4|<tuple|1.2|1>>
    <associate|auto-5|<tuple|1.3|2>>
    <associate|auto-6|<tuple|2|2>>
    <associate|auto-7|<tuple|2.1|2>>
    <associate|auto-8|<tuple|3|?>>
    <associate|auto-9|<tuple|4|?>>
    <associate|sect-comp-sec|<tuple|5|2>>
    <associate|sect-np1sec-in-pcl|<tuple|3|?|../../../.TeXmacs/texts/scratch/no_name_12.tm>>
    <associate|sect-np1sec-pclize|<tuple|4|2>>
    <associate|sect-tca-sec|<tuple|3|2>>
    <associate|sect-tdh-sec|<tuple|1.2|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      AMP10

      GKR06
    </associate>
    <\associate|table>
      <tuple|normal||<pageref|auto-3>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Security
      of Triple Diffie-Hellman Authentication>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>The Triple Diffie-Hellman
      Protocol <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>The deniablity of TDH
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Security
      of Transcript Consistency Assurance>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>(n+1)Sec
      components in PCL Langugae> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Security
      of composed sub protocols> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>