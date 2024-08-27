using IncluirCadastroFilmeFunction.app;
using IncluirCadastroFilmeFunction.domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace IncluirCadastroFilmeFunction.Tests.app
{
    public class IncluirFilmeUseCaseTests
    {

        public IncluirFilmeUseCaseTests()
        {
                
        }

        [Fact]
        public void IncluirFilme()
        {
            // Arrange
            var filme = new FilmeModel
            {
                Titulo = "hello world",
                Diretor = "Teste"
            };

            IIncluirFilmeUseCase useCase = new IncluirFilmeUseCase();

            // Act
            var retornoUseCase = useCase.Execute(filme);

            // Assert

            Assert.True(retornoUseCase);
        }
    }
}
