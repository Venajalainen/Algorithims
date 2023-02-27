# Algorithims
# Практика 1
1. Написать функцию, вычисляющую НОД двух чисел (или многочленов)

Решение.
```julia
function gcd_(a::T, b::T) where T # - это означает, что тип обоих аргументов один и тот же
    # a0, b0 = a, b
    #ИНВАРИАНТ: НОД(a,b) = HОД(a0,b0)
    while !iszero(b) # - это условие более универсальное, чем b != 0 или b > 0. Функция iszero определена для всех числовых типов. Для пользовательских типов ее надо будет определять
        a, b = b, rem(a,b) # rem(a,b) - это то же самое, что и a % b (есть еще функция mod(a,b))
    end
    return abs(a) # т.к. используется функция rem, то a может получиться отризательным
end
```

2. Написать функцию, реализующую расширенный алгоритм Евклида, вычисляющий не только НОД, но и коэффициенты его линейного представления.

**Утверждение.** Пусть d=НОД(a, b), тогда существуют такие целые коэффициенты u, v, что d=u*a+v*b

Мы спроектируем расширенный алгоритм Евклида с помощью инварианта цикла, и тем самым будет доказаго это утверждение.

Напомним, что инвариантом цикла (с передусловием) называется некотрое утверждение относительно переменных, изменяющихся в цикле, которое справедливо как перед началом выполнения цикла, так и после любого числа его повторений.

В данном случае в качестве инварианта цикла возьмём утверждение 


```julia
function gcdx_(a::T, b::T) where T # - это означает, что тип обоих аргументов один и тот же
    # a0, b0 = a, b
    u, v = one(T), zero(T) # - универсальнее, чем 1, 0 и гарантирует стабильность типов переменных
    u_, v_ = v, u
    #ИНВАРИАНТ: НОД(a,b) = HОД(a0,b0) && a = u*a0 + v*b0 && b = u_*a0 + v_ * b0
    while !iszero(b) # - это условие более универсальное, чем b != 0 или b > 0. Функция iszero определена для всех числовых типов. Для пользовательских типов ее надо будет определять
        r, k = remdiv(a,b) # remdiv(a,b) возвращает кортеж из rem(a,b) и div(a,b)
        a, b = b, r #  r = a - k*b
        u, u_ = u_, u-k*u_ # эти преобразования переменных следуют из инварианта цикла
        v, v_ = v_, v-k*v_
    end
    if isnegarive(a) #  использование функции isnegative делает данный алгоритм более универсальным, но эту функцию требуется определить, в том числе и для целых типов
        a, u, v = -a, -u, -v
    end
    return a, u, v 
end

isnegative(a::Integer) = (a < 0)
```
Интересно исследовать, как реализована встроенная функция gcdx

Для этого надо открыть ее исходный код с помощью следующей команды

```julia
julia> edit(gcdx, (Integer, Integer))
```
В функциию edit всегда надо передавать саму функцию (исходный код которой интересует) и кортеж из типов её элементов.
3. С использованием функции gcdx_ реаализовать функцию invmod_(a::T, M::T) where T, которая бы возвращала бы обратное значение инвертируемого элемента (a) кольца вычетов по модулю M, а для необращаемых элементов возвращала бы nothing.

(если положить M=b  и если d = ua+vb, то при условии, что d=1, a^-1 = u, в противном случае элемент a не обратим)

4. С использованием функции gcdx_ реализовать функцию diaphant_solve(a::T,b::T,c::T) where T, которая бы возвращала решение дафаетового уравнения ax+by=c, если уравнение разрешимо, и значение nothing - в противном случае
   
(если d=ua+vb, и если получилость, что d=1, u, v - есть решение уравнения, в противном случае уранение не разрешимо)

5. Для вычислений в кольце вычетов по модулю M определить специальный тип
   
```julia
struct Rsidue{T,M}
    a::T
    Residue{T,M}(a)where{T,M} = new(mod(a, M))
end

и определить для этого типа следующие операци и функции:
+, -, унарный минус, *, ^, inverse (обращает обратимые элементы), display (определяет, в каком виде значение будет выводиться в REPL)

6. Реализовать тип Plolynom{T} (T- тип коэффициентов многочлена)

7. Обеспечить взаимодействие типов Residue{M} и Polynom{T}, т.е. добиться, чтобы можно было бы создавать кольцо вычетов многочленов (по заданному модулю) и чтобы можно было создавить многочлены с коэффициентами из кольца вычетов.

При создании кольца вычетов многочленов параеметр M должен принимать значение кортежа коэффициентов соответсвующего многочлена.

# Практика 2

1. Написать обобщенную функцию, реализующую алгоритм быстрого возведения в степень

2. На база этой функции написать другую функцию, возвращающую n-ый член последовательности Фибоначчи (сложность - O(log n)).

3. Написать функцию, вычисляющую с заданной точностью $\log_a x$ (при произвольном $a$, не обязательно, что $a>1$), методом рассмотренном на лекции (описание этого метода можно найти также в книке Борисенко "Основы программирования" - она выложена в нашей группе в телеграм).
   
4. Написать функцию, реализующую приближенное решение уравнения вида $f(x)=0$ методом деления отрезка пополам (описание метода см. ниже). 

5. Найти приближенное решение уравнения   $\cos x = x$ методом деления отрезка пополам.

6. Написать обобщенную функцию, реализующую метод Ньютона приьлиженного решения уравнения вида $f(x)=0$ (описание метода см. ниже).

7. Методом Ньютона найти приближеннное решение уравнения $\cos x = x$.
   
8. Методом Ньютона найти приближеннное значение какого-либо вещественного корня многочлена, заданного своими коэффициенами.

**Указание.** Для вычислений значений многочлена и его производной в точке воспользоваться функцией, вычисляющей пару этих значений по схеме Горнера.

7. Построить фрактал Кэлли (описание алгоитма построения см. ниже) с помощью функций графического пакета Plots.jl или Makie.jl.

Для представления комплексных чисел в языке Julia имеется параметрический тип Complex. Стандартные функции exp, abs могут получать комплексные аргументы.  Сформировать одно конкретное комплексное значение типа Complex{Float64} можно, например, так: 1.0 + 2.5im, для сходной цели существует функция complex. Получить вещественную и мнимую части комплексой величины (или массива комплексных величин) можно с помощью функций real и imag, соответственно.

Пакет Plots.jl более прост в использовании. Он обеспечивает универсальный интерфейс к графическим пакетам PyPlot, Gr, PlotlyJs

Пакет Makie.jl - это чисто джулиевский пакет, он несколько более труден в освоении, но обеспечивает значительно большие возможности. Впрочем, для построения простых графиков он, наверное, не сложнеее Plots.jl.

С описаниями графических пакетов можно ознакомиться здесь
https://docs.juliaplots.org/latest/tutorial/

https://docs.makie.org/stable/

----
## Приближенное решение нелинейного уравнения методом деления отрезка пополам

$$
\text{f}(x)=0, \ \ \ \text{f} \in C[a;b]
$$

- на отрезке локализации $[a;b]$ уравнение имеет единственный корень;
- $\text{f}(a)\text{f}(b)<0$, т.е. на концах отрезка локализации знчения функция имеет противоположные знаки.

```julia
function bisection(f::Function, a, b, epsilon)
    @assert f(a)*f(b) < 0 
    @assert a < b
    f_a = f(a)
    #ИНВАРИАНТ: f_a*f(b) < 0
    while b-a > epsilon
        t = (a+b)/2
        f_t = f(t)
        if f_t == 0
            return t
        elseif f_a*f_t < 0
            b=t
        else
            a, f_a = t, f_t
        end
    return (a+b)/2
end
```

Графическое пояснение алгоритма представлено на рисунке
![Метод бисекций](P2_bisection.png)

----

## Метод Ньютона приближенного решения нелинейного уравнения

$$
\text{f}(x)=0, \ \ \ \text{f} \in C^1[a;b]
$$

$x_0$ - начальное приближение

Пусть после $k$ итераций получено очередное приближенное значение корня $x_k$. Тогда, воспользовавшись формулой конечных приращений Лагранжа (разложением Тейлора) исходное нелинейное уравнение можно переписать в виде

$$
\text{f}(x)=\text{f}(x_{k})+\text{f}'(x_k)(x-x_k) + o(|x-x_k|)= 0
$$

Отбрасывая в левой части этого уравнения "малый" член, получим линейную аппроксимацию исходного уравнения

$$
\text{f}(x_{k})+\text{f}'(x_k)(x_{k+1}-x_k) = 0
$$

Решая это линейное уравнение относительно $x$, получим формулу вычисления очередного $(k+1)$-приближения
$$
x_{k+1}=x_k-\frac{\text{f}(x_k)}{\text{f}'(x_k)}, \ \ \ k=0,1,2,....
$$

Геометрическая интерпретация этого шага алгоритма представлена на рисунке ![рисунок](P2_newton.png)

Метод Ньютона, применительно к случаю скалрной переменной, называют методом касательных.

Итерируя эту формулу, получим последовательность приближений $x_0,x_1,x_2,....$, кототорая при определенных условиях может сходиться к искомому корню. А может - и не сходиться, если начальное приближение $x_0$ было выбрано не удачно. Поэтому, во-первых, для останова алгоритма требуется задаться некоторой величиной $\varepsilon > 0$, и при достижении условия $x_{k+1}-x_k \le 0$ перкратить итерации, приняв за приближенное значение корня велмчину $x_{k+1}$. Во-вторых, надо задаться числом $num\_max$, на случай, если выбор начального приближения $x_0$ оказался неудачным, и сходимости не будет, и тогда при достижении $k+1 > \text{num\_max}$ прерывать цикл с выводом соответствующего передупреждения.

Для вывода предупреждения имеется специальный макрос:
```julia
@warn("Текст сообщения")
```
```julia
"""
newton(r::Function, x, epsilon; num_max = 10)

- возвращает приближенное решение уравнения вида f(x)=0
при этом предполагается, что функция r(x) = f(x)/f'(x)

"""
function newton(r::Function, x, epsilon; num_max = 10)
    dx = -r(x)
    k=0
    while abs(dx) > epsilon && k <= num_max
        x += dx
        k += 1
    end
    k > num_max && @warn("Требуемая точность не достигнута")
    return x
end
```

**Замечание 1.**
Метод Ньютона может быть использован не только для приближенного вычисления вещественных корней функции, но и для приближенного вычисления её комплексных корней. Для этого функция должна быть представима рядом Тейлора (такие функции называются аналитическими). В частности, функция может представлять собой многочлен.

При этом, в случае комплексной переменной определение самого понятия производной и правил дифференцирования, по форме, остаются остаются теми же, что и для вещественной переменной.

Пусть $f: \mathbb C \to \mathbb C$, и пусть эта функция непрерывна на $\mathbb C$. Тогда эта функция называется дифференцируемой на $\mathbb C$, если в каждой точке комплексной плоскости существует предел

$$
f'(z) = \lim_{\Delta z \to 0} \frac{f(z+\Delta z)-f(z)}{\Delta z}
$$

В таком случая этот предел называется производной аналитической функции комплексной переменной $f(z)$.

Например, $(z^n)'=nz^{n-1}$.

Поэтому полученная выше итерационная формула метода Ньютона будет годится и для приближенного вычисления комплексных корней многочленов.

## Процедура построения фрактала Кэлли

Рассмотрим уравнение $z^3=1$. Как известно это уранение имеет ровно 3 комплексных корня, расположенных эквидистантно на единичной окружности, причем один из этих корней равен 1.

Можно задаться следующим вопросом. Выберем на комплексной плоскости произвольную точку, примем ее в качестве начального приближения в методе Ньютона и начнем выполнять итерации. Спрашивается, к какому из трех корней будет сходиться получающаяся последовательность приближений.

Наивный ответ, конечно, состоит в том, что - к ближайшему от начального приближения корню. Однако этот ответ будет верен не для всех точек плоскости. Если бы вместо уравнения 3-ей степени рассматривалось уравнение 2-ой степени, то такой ответ был бы правильным для всех точек. Но для уравнения 3-ей степени и более высоких степеней это оказывается не так.

Назавем множество всех точек комплесной плоскости, начиная с которых итерационный процесс сходится к $i$-му корню (i=0,1,2), бассейном притяжения $i$-го корня. Оказывается, что границы разделяющие эти три бассейна устроены очень сложно, это не какая-то линия, это "пылео-бразное" множество, с бесконечным множеством причудливо перемешенных остравков всех трех бассейнов. Это множество отностся к так называемым фракталом (котороых разных существует бесконечное количество). Не будем уточнять понятие фрактала, укажем лишь, что фракталы устроены так, что любая часть этого множества в некотором обобщенном смысле подобна всему множеству.

Как можно визуализировать интересующие нас границы? Можно случайным образом выбирая точки комплексоной плоскости (ограничившись некоторым квадратом с центром в начаде координат и сторонами параллельными координатным осям) запускать итерационный процесс. И если будет установлено, что процесссходится к корню с индексом 0, то закрашивать эту точку одним цветом (например, красным), если - к корню с индесом 1, то закрашивать другим цветом (например, синим), если - к корню с индесом 2, то закрашивать ее третьим цветом (например, зеленым), а если тенденции к сходимости обнаружено не будет, то стартовую оставить незакрашенной (но это будет относительно редкий случай).

Если эти раскрашенные точки отобразить на графике, то на нем проступят очертания искомых границ. Важно только подобрать правильно размеры квадрата (чтобы он охватывал наиболее интересные участки плоскости), размеры точек (они должны быть маленькими, чтобы они не закрывали очень мелкие детали фрактального множества), и их число (точек должно быть очень много, ввиду малости их размеров - они должны достаточно плотно покрывать весь квадрат).
