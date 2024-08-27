using IncluirCadastroFilmeFunction.domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IncluirCadastroFilmeFunction.infra
{
    public interface IFilmesRepository
    {
        FilmeEntity Create(FilmeEntity filme);
    }
}
