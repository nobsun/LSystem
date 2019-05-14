ヒルベルト曲線という面白いものを紹介します．

ヒルベルト曲線は<a href="">L-System</a>の生成規則で以下のように記述されます．
<code>
X  ::=  + Y F - X F X - F Y +
Y  ::=  - X F + Y F Y + F X -
</code>

開始記号は X です．最初の向きは東向きです．
 + は向きを左に90度回転します．
 - は向きを右に90度回転します．
 F は前へ予め定まった距離すすみます．

これをプログラムにしたもの(抜粋)が以下です．
<pre>
f, m, p :: LSystem
f = (F:)
m = (M:)
p = (P:)

x, y :: Order -> LSystem

x 0     = id
x (n+1) = p . y n . f . m . x n . f . x n . m . f . y n . p

y 0     = id
y (n+1) = m . x n . f . p . y n . f . y n . p . f . x n . m
</pre>

とても簡単です．2次のヒルベルト曲線をL-Systemで表現すると

<pre>
+-+F-F-F+F+-F+F+F-F-F+F+F-+F+F-F-F+-F-+-F+F+F-F-+F-F-F+F+F-F-F+-F-F+F+F-+F+-F+F+F-F-+F-F-F+F+F-F-F+-F-F+F+F-+-F-+F-F-F+F+-F+F+F-F-F+F+F-+F+F-F-F+-+
</pre>

となります．以下は1次から9次までのヒルベルト曲線です．不思議な曲線ですね．
