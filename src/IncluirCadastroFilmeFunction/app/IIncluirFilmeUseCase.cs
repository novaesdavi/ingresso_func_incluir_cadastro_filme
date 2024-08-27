using IncluirCadastroFilmeFunction.domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IncluirCadastroFilmeFunction.app
{
    public interface IIncluirFilmeUseCase
    {

        bool Execute(FilmeModel filme);
    }
}
