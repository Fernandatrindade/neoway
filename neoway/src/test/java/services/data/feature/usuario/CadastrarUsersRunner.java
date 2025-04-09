package services.data.feature.usuario;

import com.intuit.karate.junit5.Karate;

class CadastrarUsersRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("cadastrarUsuario").relativeTo(getClass());
    }    

}
