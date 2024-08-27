# ingresso_func_incluir_cadastro_filme
Projeto de venda de ingresos - Lambda para inclusao de filmes no catalogo

``` shell
dotnet tool install -g Amazon.Lambda.Tools 

dotnet publish -c Release -o ./publish
```

``` json
{
  "filme": {
    "titulo": "Bob"
  }
}
```

``` shell
dotnet clean
```

``` shell
dotnet lambda invoke-function IncluirCadastroFilmeFunction --payload "$(cat .\test\IncluirCadastroFilmeFunction.Tests\LambdaInputFile.json)" out
```
