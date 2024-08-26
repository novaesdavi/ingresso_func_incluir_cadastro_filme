

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
using Amazon.Lambda.Core;
using IncluirCadastroFilmeFunction.domain;

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
        return input.Titulo.ToUpper ();
    }
}

