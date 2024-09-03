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
Teste local<br />

https://www.nuget.org/packages/Amazon.Lambda.TestTool-6.0<br />

dotnet tool install --global Amazon.Lambda.TestTool-6.0 --version 0.15.2<br />

You can invoke the tool using the following command: dotnet-lambda-test-tool-6.0
Tool 'amazon.lambda.testtool-6.0' (version '0.15.2') was successfully installed.<br />

 attach their debuggers to this tool  on dotnet-lambda-test-tool-6.0 process