package services.data.feature.usuario.deletar;

import com.intuit.karate.junit5.Karate;

class DeletarRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("deletarUsuario").relativeTo(getClass());
    }    

}
