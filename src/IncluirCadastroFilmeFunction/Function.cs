using System.Text.Json.Serialization;
using Amazon.Lambda.Core;
using Amazon.Lambda.SNSEvents; // Add this using directive for SNSEvent

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace IncluirCadastroFilmeFunction;

public class Function
{

    /// <summary>
    /// A simple function that takes a string and does a ToUpper
    /// </summary>
    /// <param name="input">The event for the Lambda function handler to process.</param>
    /// <param name="context">The ILambdaContext that provides methods for logging and describing the Lambda environment.</param>
    /// <returns></returns>
    public void FunctionHandler(SNSEvent snsEvent)
    {
        foreach (var record in snsEvent.Records)
        {
            var snsRecord = record.Sns;
            Console.WriteLine($"[{record.EventSource} {snsRecord.Timestamp}] Message = {snsRecord.Message}");
        }
    }
}

[Serializable]
public class Filme
{
    public string Titulo { get; set; }
    public int Ano { get; set; }
    public string Diretor { get; set; }
}