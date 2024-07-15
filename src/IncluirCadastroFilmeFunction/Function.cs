using System.Text.Json.Serialization;
using Amazon.Lambda.Core;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly : LambdaSerializer (typeof (Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace IncluirCadastroFilmeFunction;

public class Function {

    /// <summary>
    /// A simple function that takes a string and does a ToUpper
    /// </summary>
    /// <param name="input">The event for the Lambda function handler to process.</param>
    /// <param name="context">The ILambdaContext that provides methods for logging and describing the Lambda environment.</param>
    /// <returns></returns>
    public string FunctionHandler (Filme input, ILambdaContext context) {
        return input.Titulo;
    }
}

[JsonSerializable (typeof (Filme))]
public class Filme {
    public string Titulo { get; set; }
    public int Ano { get; set; }
    public string Diretor { get; set; }
}