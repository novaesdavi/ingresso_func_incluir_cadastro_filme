using Amazon.Lambda.Core;
using Amazon.Lambda.TestUtilities;
using IncluirCadastroFilmeFunction.domain;
using Xunit;

namespace IncluirCadastroFilmeFunction.Tests;

public class FunctionTest {
    [Fact]
    public void TestToUpperFunction () {

        var filme = new Filme {
            Titulo = "hello world",
            Diretor = "Teste"
        };

        // Invoke the lambda function and confirm the string was upper cased.
        var function = new Function ();
        var context = new TestLambdaContext ();

        var upperCase = function.FunctionHandler (filme, context);

        Assert.Equal ("HELLO WORLD", upperCase);
    }
}