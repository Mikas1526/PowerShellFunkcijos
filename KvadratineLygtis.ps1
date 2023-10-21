<#
.SYNOPSIS
Kvadratinės lygties sprendinių ir parabolės viršūnės skaičiavimo funkcija.
.DESCRIPTION
- Funkcija gali apskaičiuoti kvardatinės lygties ax^2 + bx + c = 0 sprendinius.
- Funkcija gali nurodyti parabolės y = ax^2 + bx + c viršūnės koordinates.
- Funkcija gali pateikti skaičiavimus.
.INPUTS
a, b ir c yra realūs skaičiai, kurie priima int ir float duomenų tipus.
.OUTPUTS
Lentelės pavidalu pateikiami užduoties sprendimai.
Jeigu kvadratinės lygties sprendinių rasti nepavyko ar a = 0 - metama klaida
.PARAMETER a
Pirmasis kvadratinės lygties ir parabolės funkcijos narys, kurio reikšmę privaloma nurodyti ir negali būti 0.
Jeigu a reikšmė nurodoma 0 - metama klaida.
.PARAMETER b
Antrasis kvadratinės lygties ir parabolės funkcijos narys.
Reikšmė pagal nutylėjimą yra 0.
.PARAMETER c
Trečiasis kvadratinės lygties ir parabolės funkcijos narys.
Reikšmė pagal nutylėjimą yra 0.
.PARAMETER SolveType
Nurodo, ką daryti su a, b ir c nariais: su jais spręsti kvadratinę lygtį ar ieškoti parabolės viršūnės.
Pasirenkama tarp Equation (kvadratinė lygtis) ir Vertex (parabolės viršūnės).
Pagal nutylėjimą skaičiuojama kvadratinė lygtis.
.PARAMETER ShowSteps
Paliepia parodyti funkcijai sprendimų eigą.
.EXAMPLE
C:\> Solve-Quadratic 4 2 -50 -ShowSteps
1. Calculating discriminant
D = b^2 - 4ac = 2^2 - 4 * 4 * -50 = 804
2. Solving for X
X1 = (-b + D^0.5) / (2a) = (-2 + 804^0.5) / (2 * 4) = 3.294
X2 = (-b - D^0.5) / (2a) = (-2 + 804^0.5) / (2 * 4) = -3.794
3. Answer

Name Value
---- -----
X1   3.294
X2   -3.794
.EXAMPLE
C:\> Solve-Quadratic -a 4 -b 4 -c 1

Name Value
---- -----
X    -0.5
.EXAMPLE
C:\> Solve-Quadratic -a 4 -c 1 -SolveType Equation
X cannot be found because discriminant is negative
.EXAMPLE
C:\> Solve-Quadratic 1 0 0 Vertex

Name Value
---- -----
X    -0
Y    0
.LINK
https://github.com/Mikas1526
#>
function Solve-Quadratic
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [float]$a,
        [float]$b = 0,
        [float]$c = 0,
        [ValidateSet('Equation', 'Vertex')]
        $SolveType = 'Equation',
        [switch]$ShowSteps
    )

    if ($a -eq 0)
    {
        Write-Error "Quadrantic equation paramater a cannot be 0"
    }
    else
    {
        $format = "0.###"

        switch ($SolveType) {
            'Vertex'
            {
                $X1 = (-1 * $b) / (2 * $a)
                $Y = $a * [MathF]::Pow($X, 2.0) + $X1 * $b + $c
                
                $X1 = $X1.ToString($format)
                $Y = $Y.ToString($format)

                if ($ShowSteps)
                {
                    Write-Host "1. Solving for X" -ForegroundColor White -BackgroundColor Blue
                    "X = -b / 2a = {0} / {1} = {2}" -f $(-1 * $b).ToString($format), $(2 * $a).ToString($format), $X1
                    
                    Write-Host "2. Solving for Y" -ForegroundColor White -BackgroundColor Blue
                    "Y = ax^2 + bx + c = {0} * {2}^2 + {1} {2} + c = {3}" -f $a.ToString($format), $b.ToString($format), $X1, $Y
                    
                    Write-Host "3. Answer" -ForegroundColor White -BackgroundColor Blue
                }
                @{X = $X1; Y = $Y} | Format-Table -AutoSize
            }
            Default
            {
                $D = [MathF]::Pow($b, 2.0) - (4 * $a * $c)
                if ($ShowSteps)
                {
                    Write-Host "1. Calculating discriminant" -ForegroundColor White -BackgroundColor Blue
                    "D = b^2 - 4ac = {1}^2 - 4 * {0} * {2} = {3}" -f $a.ToString($format), $b.ToString($format), $c.ToString($format), $D
                }
                if ($D -gt 0)
                {
                    $X1 = ((-1 * $b + [MathF]::Sqrt($D)) / (2 * $a)).ToString($format)
                    $X2 = ((-1 * $b - [MathF]::Sqrt($D)) / (2 * $a)).ToString($format)
                    if ($ShowSteps)
                    {
                        Write-Host "2. Solving for X" -ForegroundColor White -BackgroundColor Blue
                        "X1 = (-b + D^0.5) / (2a) = (-{1} + {2}^0.5) / (2 * {0}) = {3}" -f $a.ToString($format), $b.ToString($format), $D.ToString($format), $X1
                        "X2 = (-b - D^0.5) / (2a) = (-{1} + {2}^0.5) / (2 * {0}) = {3}" -f $a.ToString($format), $b.ToString($format), $D.ToString($format), $X2

                        Write-Host "3. Answer" -ForegroundColor White -BackgroundColor Blue
                    }
                    @{X1 = $X1; X2 = $X2} | Format-Table -AutoSize
                }
                elseif ($D -eq 0) {

                    $X1 = ((-1 * $b) / (2 * $a)).ToString($format)
                    if ($ShowSteps)
                    {
                        Write-Host "2. Solving for X" -ForegroundColor White -BackgroundColor Blue
                        "X = -b / 2a = -{1} / (2 * {0}) = {2}" -f $a.ToString($format), $b.ToString($format), $X1

                        Write-Host "3. Answer" -ForegroundColor White -BackgroundColor Blue
                    }
                    
                    @{X = $X1} | Format-Table -AutoSize
                }
                else {
                    if ($ShowSteps)
                    {
                        Write-Host "2. Answer" -ForegroundColor White -BackgroundColor Blue
                    }
                    Write-Host "X cannot be found because discriminant is negative" -ForegroundColor DarkRed
                }
            }
        }
    }
}
