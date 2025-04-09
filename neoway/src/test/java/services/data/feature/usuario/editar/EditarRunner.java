package services.data.feature.usuario.editar;

import com.intuit.karate.junit5.Karate;

class EditarRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("editarUsuario").relativeTo(getClass());
    }    

}
