package services.data.feature.produto;

import com.intuit.karate.junit5.Karate;

class DeletarRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("deletarProduto").relativeTo(getClass());
    }    

}
