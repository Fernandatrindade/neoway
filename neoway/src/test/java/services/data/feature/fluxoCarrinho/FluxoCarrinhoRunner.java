package services.data.feature.fluxoCarrinho;

import com.intuit.karate.junit5.Karate;

class FluxoCarrinhoRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("fluxoCarrinho").relativeTo(getClass());
    }    

}
